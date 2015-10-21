add_spices do
  opt :logfile, "output log to a file", :short => '-w', :type => :string
  opt :post, "log ssl POSTs", :short => '-p'
  opt :ssl, "log all SSLd traffic", :short => '-s'
  opt :all, "log all traffic", :short => '-a'
  opt :lport, "listening port", :short => 'l', :type => :int
  opt :favicon, "insert lock favicon", :short => '-f'
  opt :killsessions, "kills any active sessions", :short => '-k'
end

requirements do
  check_bin "sslstrip"
end

cook do
  command_options = ""
  command_options << "#{@spices[:logfile]} "
  command_optios << "#{@spices[:post]} "
  command_optios << "#{@spices[:ssl]} "
  command_optios << "#{@spices[:all]} "
  command_optios << "#{@spices[:lport]} "
  command_optios << "#{@spices[:favicon]} "
  command_optios << "#{@spices[:killsessions]} "

  cmd "sslstrip #{command_options} &"
end

cleanup do
  kill "sslstrip"
  end