add_spices do
  opt :bssid, "set Access Point MAC address", :short => '-a', :type => :string
  opt :monitor, "Replay interface", :short => '-m', :type => :string
  opt :iface, "capture packets from this interface", :short => '-i', :type => :string
  opt :wep, "use this WEP key to encrypt/decrypt packets", :short => '-w', :type => :string
  opt :mitm_source, "source mac for MITM mode", :short => '-h', :type => :string
  opt :disallow, "disallow specified client MACs (default: allow)", :short => '-f'
  opt :wep_flag, "[don't] set WEP flag in beacons 0|1 (default: auto)", :short => '-W', :type => :int
  opt :quiet, "quiet (do not print statistics)", :short => '-q'
  opt :verbose, "verbose (print more messages)", :short => '-v'
  opt :ad_hoc, "Ad-Hoc Mode (allows other clients to peer)", :short => '-A'
  opt :process, "in|out|both : external packet processing", :short => '-Y', :type => :string
  opt :channel, "sets the channel the AP is running on", :short => '-c', :type => :int
  opt :hidden, "hidden ESSID", :short => '-X'
  opt :force_shared_key, "force shared key authentication", :short => '-s'
  opt :challenge_length, "set shared key challenge length (default: 128)", :short => '-S', :type => :int
  opt :caffe_latte, "Caffe-Latte attack", :short => '-L'
  opt :cfrog, "Hirte attack (cfrag attack), creates arp request against wep client", :short => '-N'
  opt :packets_per_second, "number of packets per second (default: 100)", :short => '-x', :type => :int
  opt :disable_response, "disables responses to broadcast probes", :short => '-y'
  opt :enable_tags, "set all WPA,WEP,open tags. can't be used with -z & -Z"
  opt :wpa1, "sets WPA1 tags. 1=WEP40 2=TKIP 3=WRAP 4=CCMP 5=WEP104", :short => '-z', :type => :int
  opt :wpa2, "sets WPA1 tags. 1=WEP40 2=TKIP 3=WRAP 4=CCMP 5=WEP104", :short => '-Z', :type => :int
  opt :fake_eapol, "fake EAPOL 1=MD5 2=SHA1 3=auto", :short => '-V', :type => :int
  opt :pcap_file_prefix, "write all sent and received frames into pcap file", :short => '-F', :type => :string
  opt :respond_to_all, "respond to all probes, even when specifying ESSIDs", :short => '-P'
  opt :interval, "ets the beacon interval value in ms", :short => '-I', :type => :int
  opt :essid_beacon_interval, "enables beaconing of probed ESSID values for specified interval", :short => '-C', :type => :int
  opt :bssid_filter, "BSSID to filter/use", :short => '-b', :type => :string
  opt :bssids_file, "read a list of BSSIDs out of that file", :short => '-B', :type => :string
  opt :client, "MAC of client to accept", :short => '-d', :type => :string
  opt :clients_file, "read a list of MACs out of that file", :short => '-D', :type => :string
  opt :essid, "specify a single ESSID", :short => '-e', :type => :string
  opt :essids_file, "read a list of ESSIDs out of that file", :short => '-E', :type => :string
  opt :override, "Force rung with this string instead of individual options (Does not check requirements)", :type => :string
  opt :log_file, "Write output to this file", :type => :string
end

requirements do
  check_bin "airbase-ng"
  unless @spices[:monitor]
    raise "Airbase requires replay interface.  Ex: mon0"
  end
  
  if @spices[:wep] and (@spices[:wpa1] or @spices[:wpa2])
    raise "Airbase can not use WEP with WPA for airbase"
  end
  
  if @spices[:wpa1] and @spices[:wpa2]
    raise "Airbase can not use WPA1 and WPA2 for airbase"
  end
  
  if (@spices[:force_shared_key] or spices[:challenge_length]) and !(@spices[:wpa1] and !@spices[:wpa2])
    raise "Airbase can not for shared key without specifying WPA1 or WPA1."
  end
  
  if @spices[:hidden] and !@spices[:essid]
    raise "Airbase can not run in hidden mode without specfying essid"
  end
  
  if @spices[:enable_tags] and (@spices[:wpa1] or @spices[:wpa2])
    raise "Airbase can not use the -0 flag with -z or -Z"
  end
    
end

cook do
  command_options = ""
  if @spices[:override]
    command_options << "#{@spices[:override]} "
  else
    command_options << "-a #{@spices[:bssid]} " if @spices[:bssid]
    command_options << "-i #{@spices[:iface]} " if @spices[:iface]
    command_options << "-w #{@spices[:wep]} " if @spices[:wep]
    command_options << "-h #{@spices[:mitm_source]} " if @spices[:mitm_source]
    command_options << "-f #{@spices[:disallow]} " if @spices[:disallow]
    command_options << "-W #{@spices[:wep_flag]} " if @spices[:wep_flag]
    command_options << "-q " if @spices[:quiet]
    command_options << "-v " if @spices[:verbose]
    command_options << "-A " if @spices[:ad_hoc]
    command_options << "-Y #{@spices[:process]} " if @spices[:process]
    command_options << "-c #{@spices[:channel]} " if @spices[:channel]
    command_options << "-X " if @spices[:hidden]
    command_options << "-s " if @spices[:force_shared_key]
    command_options << "-S #{@spices[:challenge_lengeth]} " if @spices[:challenge_length]
    command_options << "-L " if @spices[:caffe_latte]
    command_options << "-N " if @spices[:cfrog]
    command_options << "-x #{@spices[:packets_per_second]} " if @spices[:packets_per_second]
    command_options << "-y " if @spices[:disable_response]
    command_options << "-0 " if @spices[:enable_tags]
    command_options << "-z #{@spices[:wpa1]} " if @spices[:wpa1]
    command_options << "-Z #{@spices[:wpa1]} " if @spices[:wpa2]
    command_options << "-V #{@spices[:fake_eapol]} " if @spices[:fake_eapol]
    command_options << "-F #{@spices[:pcap_file_prefix]} " if @spices[:pcap_file_prefix]
    command_options << "-P " if @spices[:respond_to_all]
    command_options << "-I #{@spices[:interval]} " if @spices[:interval]
    command_options << "-C #{ @spices[:essid_beacon_interval]} " if @spices[:essid_beacon_interval]
    command_options << "-b #{@spices[:bssid_filter]} " if @spices[:bssid_filter]
    command_options << "-B #{@spices[:bssids_file]} " if @spices[:bssids_file]
    command_options << "-d #{@spices[:client]} " if @spices[:client]
    command_options << "-D #{@spices[:clients_file]} " if @spices[:clients_file]
    command_options << "-e #{@spices[:essid]} " if @spices[:essid]
    command_options << "-E #{@spices[:essids_file]} " if @spices[:essids_file] 
  end
  command_options << "#{@spices[:monitor]} "
  command_options << "> #{@spices[:log_file]} " if @spices[:log_file] 
  cmd "airbase-ng #{command_options} &"
end

cleanup do
  kill "airbase-ng"
end