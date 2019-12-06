Vagrant-Ansible-Windows
=======================
or, "I only need Windows for this one app..."

This repo tracks my work to use [Ansible](http://www.ansible.com) to
automate a [Vagrant](http://www.vagrantup.com) environment for a
"daily-driver" Windows desktop.

NOTICE: As I no longer use a Mac, Windows 10 support is being built in [Boxstarter](https://boxstarter.org/ ), which can run on the target machine directly, rather than Ansible with requires a Mac/Linux control machine.

Setup (Win 10 + Boxstarter)(Local)
----------------------------------

1. Install latest Boxstarter from [boxstarter.org](https://boxstarter.org/ )
2. Run from Boxstarter Shell with: `Install-BoxstarterPackage -PackageName <GitHub Raw URL to provisioning/boxstarter.ps1> -DisableReboots`

Setup (Vagrant + Win10 + )
--------------------------

Requires:

Setup (Win 7 + Vagrant + Ansible)
---------------------------------

1. Clone this repo. remember that the VM is going to use 2GB of RAM. You
   can reduce this in the Vagrantfile, but less than 2GB will cause
Windows Updates to fail.
2. Download the requisite Microsoft features that the Vagrantfile is
   going to install:

  * .NET 4.5.1 Full Installer
  * WMF 3.0 Installer

3. Run `vagrant up` to download the windows 7 x64 .box, make a copy of it for a
   running instance, and run the provisioners (scripts) embedded in the
Vagrantfile and also the Ansible playbooks in provisioning/playbook*.yml

Windows Login Security
----------------------

put an encrypted file windows.yml into provisioning/group_vars/ with the contents:
```yaml
  ansible_ssh_user: vagrant
  ansible_ssh_pass: <password>
  ansible_ssh_port: 55986
  ansible_connection: winrm
```

1. use `ansible vault create provisioning/group_vars/windows.yml`
2. then `ansible vault edit provisioning/group_vars/windows.yml` to edit in
your $EDITOR

File Descriptions
-----------------
fix-ssl.py works around the fact that Vagrant can use WinRM in
plaintext, but Ansible cannot. I think.

gitignored files
----------------
