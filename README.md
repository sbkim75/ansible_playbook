# ansible_playbook

# ansible-playbook check option
ansible-playbook -i inventory --check helloworld.yml

# debug
---
- name: Hello World sample
  hosts: all
  tasks:
  - name: Hello message
    debug:
      msg: "Hello World!"
      verbosity:2

      