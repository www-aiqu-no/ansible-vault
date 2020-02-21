# Role Name

This is a simple ansible role for vault. It does the following tasks:
- Download and validate precompiled binary
- Add unit/service definition (systemd)
- Stream configuration based on provided parameters into json-configuration
- Optional: manage firewalld, selinux

## Requirements

None

## Role Variables

All role-variables are optional

#### version (default: 1.3.2)

Sets the version to download & enable

#### force_install (default: false)

Download & unpack binary even if the defined version already exists

#### config_overrides (default: {})

Overrides any default settings for the application. These are written to disk on the host. Example:
```yaml
config_overrides:
  ui: true
  storage:
    file:
      path: "{{ path.storage }}/{{ application }}/data"
  listener:
    tcp:
      address: "127.0.0.1:8200"
      tls_disable: "true"
  telemetry:
    prometheus_retention_time: 12h
```

#### path_overrides (default: {})

Default paths to use for files

#### configure_firewalld (default: false)

Add (default) ports to firewalld

#### configure_selinux (default: false)

Set SELinux to permissive mode

## Dependencies

None

## Example Playbook

Install a single server instance

    - hosts: localhost
      gather_facts: false

      pre_tasks:
        - name: Ansible and docker requirements
          become: true
          package:
            name:
              - iproute
            state: present

      tasks:
        - include_role:
            name: vault
          vars:
            config_overrides:
              ui: true
              storage:
                file:
                  path: "{{ path.storage }}/{{ application }}/data"
              listener:
                tcp:
                  address: "127.0.0.1:8200"
                  tls_disable: "true"
              telemetry:
                prometheus_retention_time: 12h

## License

MIT

## Author Information

N/A
