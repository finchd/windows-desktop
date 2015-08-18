Vagrant-Ansible-Windows
=======================
or, "I only need Windows for this one app..."

NOTICE: Ansible's chocolatey module (win_chocolatey) currently does not
work. at all. this is because of changes in chocolatey's commandline
parsing. (Ansible v1.9.X)

This repo tracks my work to use [Ansible](http://www.ansible.com) to
automate a [Vagrant](http://www.vagrantup.com) environment for a
"daily-driver" Windows desktop. Resisting the urge to put the MS
update/patches necessary for Windows 7 Ansible support into the repo
for now.

Setup
-----

1. Clone this repo. remember that the VM is going to use 2GB of RAM. You
   can reduce this in the Vagrantfile, but less than 2GB will cause
Windows Updates to fail.
2. Download the requisite Microsoft features that the Vagrantfile is
   going to install:

  * .NET 4.5.1 Full Installer
  * WMF 3.0 Installer

3. Run `vagrant up` to download the windows 7 x64 .box, then copy it a
   running instance, and run the provisioners (scripts) embedded in the
Vagrantfile and also the Ansible playbooks in provisioning/playbook*.yml

Windows Login Security
----------------------

put an encrypted file windows.yml into provisioning/group_vars/ with the contents:
  ansible_ssh_user: vagrant
  ansible_ssh_pass: <password>
  ansible_ssh_port: 55986
  ansible_connection: winrm

use `ansible vault create provisioning/group_vars/windows.yml`
then `ansible vault edit provisioning/group_vars/windows.yml` to edit in
your $EDITOR

File Descriptions
-----------------
fix-ssl.py works around the fact that Vagrant can use WinRM in
plaintext, but Ansible cannot. I think.

gitignored files

NDP451\*.msu is .net 4.5.1

KB\*143\*.msu is WMF 3.0 including PowerShell 3.0

KB\*745\*.msu is WMF 4.0 including PowerShell 4.0
