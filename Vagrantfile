# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 st=2 et :
# frozen_string_literal: true

Vagrant.configure('2') do |config|
    config.vm.box = 'debian/buster64'
    config.vm.box_check_update = false

    # Limiter la RAM des VM
    config.vm.provider 'virtualbox' do |vb|
        # vb.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
        vb.memory = '1000'
        vb.cpus = 1
        vb.gui = false
    end

    # Mettre en place un cache pour APT
    # config.vm.synced_folder 'v-cache', '/var/cache/apt'

    config.vm.define 'control' do |machine|
        machine.vm.hostname = 'control'
        machine.vm.network 'private_network', ip: '192.168.50.250'
    end

    config.vm.define 'revproxy' do |machine|
        machine.vm.hostname = 'revproxy'
        machine.vm.network 'private_network', ip: '192.168.50.10'
    end

    config.vm.define 'app1' do |machine|
        machine.vm.hostname = 'app1'
        machine.vm.network 'private_network', ip: '192.168.50.20'
    end

    config.vm.define 'app2' do |machine|
        machine.vm.hostname = 'app2'
        machine.vm.network 'private_network', ip: '192.168.50.30'
    end

    config.vm.define 'db' do |machine|
        machine.vm.hostname = 'db'
        machine.vm.network 'private_network', ip: '192.168.50.40'
    end

    config.vm.define 'cache' do |machine|
        machine.vm.hostname = 'cache'
        machine.vm.network 'private_network', ip: '192.168.50.50'
    end

    config.vm.provision 'shell', path: 'provision.sh'
end
  