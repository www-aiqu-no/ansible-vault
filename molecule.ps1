# Requires Docker desktop for Windows & powershell
# https://molecule.readthedocs.io/en/latest/
param (
    [string]$command       = "list",
    [string]$scenario      = "default",
    [string]$image_name    = "centos",
    [string]$image_version = "7"
)

docker run --rm -it --privileged `
  -w /vault `
  -v $pwd/:/vault:ro `
  -v /var/run/docker.sock:/var/run/docker.sock:rw `
  -e image_name=$image_name `
  -e image_version=$image_version `
  quay.io/ansible/molecule:latest `
  molecule $command --scenario-name $scenario
