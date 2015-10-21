def ip_forwarding?
  return false unless File.file?( '/proc/sys/net/ipv4/ip_forward')
  File.read('/proc/sys/net/ipv4/ip_forward').strip == "1"
end

def set_ip_forwarding
  File.open('/proc/sys/net/ipv4/ip_forward', 'w'){|f| f.puts value} unless ip_forwarding?
end

def unset_ip_forwarding
  File.open('/proc/sys/net/ipv4/ip_forward', 'w'){|f| f.puts value} if ip_forwarding?
end