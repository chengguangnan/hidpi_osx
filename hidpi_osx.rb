require 'base64'
require 'fileutils'

ioreg = `ioreg -l`.scrub.lines


displays = ioreg.grep(/DisplayVendorID/)

system_dir = "/System/Library/Displays/Overrides"

displays.size.times do |i|

  vendor_id = ioreg.grep(/DisplayVendorID/)[i].match(/= (.*)/)[1]

  # skip apple displays
  next if vendor_id == "1552"



  product_id = ioreg.grep(/DisplayProductID/)[i].match(/= (.*)/)[1]
  edid = ioreg.grep(/IODisplayEDID/)[i].match(/<(.*)>/)[1]

  resolutions = [[1280, 800]]

  vendor_dir = File.join(system_dir, "DisplayVendorID-#{vendor_id}")
  plist_path = File.join(vendor_dir, "DisplayProductID-#{product_id}")

  plist = %Q[
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <dict>
          <key>DisplayProductID</key>
          <integer>#{product_id}</integer>
          <key>DisplayVendorID</key>
          <integer>#{vendor_id}</integer>
          <key>IODisplayEDID</key>
          <data>
          #{Base64.encode64([edid].pack('H*'))}</data>
          <key>scale-resolutions</key>
          <array>
          #{resolutions.map{|w, h| "<data>#{Base64.encode64([w, h, 1].pack('N*')).strip}</data>" }.join("\n")}
          </array>
  </dict>
  </plist>].strip

  puts plist

  begin
    FileUtils.mkdir_p(vendor_dir)
    File.open(plist_path, "w") do |f|
      f.puts plist
    end
  rescue Errno::EACCES
    warn "Please run this command with sudo, and turn off File System Protection in El Capitain"
  end
end
