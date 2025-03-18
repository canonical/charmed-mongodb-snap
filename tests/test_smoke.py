import yaml
import subprocess
import time
import pytest
from pathlib import Path


def test_install():
    with open("snap/snapcraft.yaml") as file:
        snapcraft = yaml.safe_load(file)

        subprocess.run(
            f"sudo snap install ./{snapcraft['name']}_{snapcraft['version']}_amd64.snap --devmode".split(),
            check=True,
        )


@pytest.mark.run(after="test_install")
def test_all_apps():
    with open("snap/snapcraft.yaml") as file:
        snapcraft = yaml.safe_load(file)

        override = {}

        skip = []

        for app, data in snapcraft["apps"].items():
            if not bool(data.get("daemon")) and app not in skip:
                print(f"Testing {snapcraft['name']}.{app}....")
                subprocess.run(
                    f"{snapcraft['name']}.{app} {override.get(app, '--help')}".split(),
                    check=True,
                )


@pytest.mark.run(after="test_install")
def test_all_services():
    with open("snap/snapcraft.yaml") as file:
        snapcraft = yaml.safe_load(file)

        skip = []

        for app, data in snapcraft["apps"].items():
            if bool(data.get("daemon")) and app not in skip:
                print(f"\nTesting {snapcraft['name']}.{app} service....")
                subprocess.run(
                    f"sudo snap start {snapcraft['name']}.{app}".split(), check=True
                )
                time.sleep(5)
                service = subprocess.run(
                    f"snap services {snapcraft['name']}.{app}".split(),
                    check=True,
                    capture_output=True,
                )
                subprocess.run(f"sudo snap stop {snapcraft['name']}.{app}".split())

                assert "active" in str(service.stdout)


@pytest.mark.run(after="test_all_services")
def test_remove():
    with open("snap/snapcraft.yaml") as file:
        snapcraft = yaml.safe_load(file)
    subprocess.run(f"sudo snap remove --purge {snapcraft['name']}".split())


@pytest.mark.run(after="test_remove")
def test_refresh():
    with open("snap/snapcraft.yaml") as file:
        snapcraft = yaml.safe_load(file)

    subprocess.run(f"sudo snap install --channel 6/edge {snapcraft['name']}".split())

    subprocess.run(
        f"sudo snap install ./{snapcraft['name']}_{snapcraft['version']}_amd64.snap --devmode".split(),
        check=True,
    )

    mandatory_files = [
        Path("/var/snap/charmed-mongodb/current/etc/mongod/mongod.conf"),
        Path("/var/snap/charmed-mongodb/current/etc/mongod/mongos.conf"),
        Path("/var/snap/charmed-mongodb/current/etc/ldap/ldap.conf"),
    ]

    for file_path in mandatory_files:
        assert file_path.is_file()


@pytest.mark.run(after="test_refresh")
def test_final_remove():
    with open("snap/snapcraft.yaml") as file:
        snapcraft = yaml.safe_load(file)
    subprocess.run(f"sudo snap remove --purge {snapcraft['name']}".split())
