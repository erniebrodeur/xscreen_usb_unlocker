# -*- encoding: utf-8 -*-
require File.expand_path('../lib/xscreen_usb_unlocker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ernie Brodeur"]
  gem.email         = ["ebrodeur@ujami.net"]
  gem.description   = "A CLI tool that scans your usb ports for a device, then locks/unlocks xscreensaver."
  gem.summary       = "This tool is used to control xscreensaver via a USB device being plugged in and removed.  It provides minor methods to scan for unique device, like serial and device id.  This is rather useful with a smart phone."
  gem.homepage      = "https://github.com/erniebrodeur/xscreen_usb_unlocker"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "xscreen_usb_unlocker"
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "rb-inotify"
  gem.add_runtime_dependency "libusb"
  gem.add_runtime_dependency "yajl-ruby"
  gem.add_runtime_dependency "sys-proctable"
  gem.add_development_dependency "pry"
  gem.version       = XscreenUsbUnlocker::VERSION
end
