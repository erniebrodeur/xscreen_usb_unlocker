require 'rb-inotify'
require 'libusb'
require 'yajl'
require 'sys/proctable'

require 'xscreen_usb_unlocker/app'
require 'xscreen_usb_unlocker/log'
require 'xscreen_usb_unlocker/config'
require 'xscreen_usb_unlocker/optparser'
require "xscreen_usb_unlocker/version"

module XscreenUsbUnlocker
  def self.lock_screen
    Log.info 'locking'
    p = spawn "xscreensaver -no-splash"
    Process.detach p
    %x[xscreensaver-command -lock]
  end

  def self.unlock_screen
    Log.info 'unlocking'

    if xscreensaver_pids
      xscreensaver_pids.each do |p|
        Log.info "Appears to be pid: #{p.pid}"
        Process.kill "QUIT", p.pid
      end
    end
  end

  def self.xscreensaver_running?
    xscreensaver_pids.any?
  end

  def self.xscreensaver_pids
    Sys::ProcTable.ps.select{|x| x.cmdline.include?("xscreensaver") && !x.cmdline.include?("ruby")}
  end

  def self.plugged_in?
    usb = LIBUSB::Context.new
    options_hash = {}

    if Options[:device]
      v, p = Options[:device].split(":")
      options_hash[:idVendor] = v.hex if v && !v.empty?
      options_hash[:idProduct] = p.hex if p && !p.empty?
    end

    devices = usb.devices(options_hash)
    return true if devices.select { |d| d.serial_number == Options[:serial]}.any?
    false
  end

  def self.toggle_lock
    if plugged_in?
      Log.info 'unlock requested'
      unlock_screen
    else
      Log.info 'lock request'
      lock_screen
    end
  end
end
