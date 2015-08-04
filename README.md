Vagrant-Ansible-Windows
=======================
or, "I only need Windows for this one app..."

This repo tracks my work to use [Ansible](http://www.ansible.com) to
automate a [Vagrant](http://www.vagrantup.com) environment for a
"daily-driver" Windows desktop. Resisting the urge to put the MS
update/patches necessary for Windows 7 Ansible support into the repo
for now.

File Descriptions
-----------------
fix-ssl.py works around the fact that Vagrant can use WinRM in
plaintext, but Ansible cannot. I think.

gitignored files

NDP451\*.msu is .net 4.5.1

KB\*143\*.msu is WMF 3.0 including PowerShell 3.0

KB\*745\*.msu is WMF 4.0 including PowerShell 4.0
