# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ferventcoder/win7pro-x64-nocm-lite"

  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.ssh.insert_key = false

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #config.vm.network "forwarded_port", guest: 22, host: 2201 # no automatic ssh forwarding for guest=:windows
  #config.vm.network "forwarded_port", guest: 5836, host: 55836

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "2048" # must be 2048 or higher for Windows Update to complete
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  # extend remote powershell allowances for vagrant provisioners
  config.vm.provision "shell", inline: <<-SHELL
    winrm set winrm/config/winrs '@{MaxShellsPerUser="100"}'
    winrm set winrm/config/winrs '@{MaxProcessesPerShell="100"}'
  SHELL

  # install .NET 4.5.1
  # install PowerShell/Windows Management Framework 3

  # configure windows updates to be dl-only?
  #Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU\\AUoptions" -Name newproperty  -Value "4"
  #
  config.vm.provision "shell", inline: <<-SHELL
    echo "Check shared folder mount point"
    cd C:\\vagrant
    dir
    echo "Start Windows Update Service"
    Set-Service wuauserv -StartupType Manual
    Start-Service -Name wuauserv
    Get-Service wuauserv
    echo "Installing .NET 4.5.1"
    Start-Process -FilePath C:\\vagrant\\NDP451-KB2858728-x86-x64-AllOS-ENU.exe -Wait -ArgumentList /norestart /passive
    echo "1st Reboot - .NET 4.5.1 installed"
  SHELL

  if Vagrant.has_plugin?("vagrant-reload")
    config.vm.provision :reload
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Check shared folder mount point"
    cd C:\\vagrant
    dir
    echo "Start Windows Update Service"
    Set-Service wuauserv -StartupType Manual
    Start-Service -Name wuauserv
    Get-Service wuauserv
    echo "Installing WMF 3.0"
    Start-Process -FilePath C:\\vagrant\\Windows6.1-KB2506143-x64.msu -Wait -ArgumentList /quiet
    echo "2nd Reboot - WMF installed"
  SHELL


  if Vagrant.has_plugin?("vagrant-reload")
    config.vm.provision :reload
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "configure WinRM for Ansible using their script"
    C:\\vagrant\\ConfigureRemotingForAnsible.ps1
  SHELL

  #install Chocolatey manually https://github.com/ansible/ansible-modules-extras/issues/378
  config.vm.provision "shell", inline: <<-SHELL
    echo "Install Chocolatey manually"
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    echo "2nd Reboot - chocolatey"
  SHELL

  if Vagrant.has_plugin?("vagrant-reload")
    config.vm.provision :reload
  end


  # next, test Ansible's WinRM connection
  config.vm.provision "ansible", run: "always" do |ansible|
    ansible.playbook = "provisioning/playbook.yaml"
    ansible.inventory_path = "provisioning/inventory"
    ansible.groups = {
      "windows" => ["default"]
    }
    ansible.ask_vault_pass = true
    #ansible.verbose  = "vv"
  end

  # If successful, then run the below to install chocolatey packages, and my other favorite Windows tools.
  #`ansible-playbook --connection=winrm --user=vagrant --ask-vault-pass --inventory-file=provisioning/inventory -vvv provisioning/playbook-adv.yaml`
  # or....
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/playbook-adv.yaml"
    ansible.inventory_path = "provisioning/inventory"
    ansible.groups = {
      "windows" => ["default"]
    }
    ansible.ask_vault_pass = true
    ansible.verbose  = "vvvv"
  end

end
