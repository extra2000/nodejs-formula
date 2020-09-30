# -*- coding: utf-8 -*-
# vim: ft=sls

/opt/nvm-installer.sh:
  file.managed:
    - source: https://raw.githubusercontent.com/nvm-sh/nvm/v{{ pillar['nodejs']['nvm']['version'] }}/install.sh
    - skip_verify: true
    - mode: 555
    - force: true

install-nvm:
  cmd.run:
    - name: /opt/nvm-installer.sh
    - runas: {{ pillar['nodejs']['nvm']['user'] }}
    - require:
      - file: /opt/nvm-installer.sh

install-nodejs-{{ pillar['nodejs']['version'] }}:
  cmd.run:
    - name: |
        source /home/{{ pillar['nodejs']['nvm']['user'] }}/.nvm/nvm.sh
        nvm install {{ pillar['nodejs']['version'] }}
    - runas: {{ pillar['nodejs']['nvm']['user'] }}
    - require:
      - cmd: install-nvm
