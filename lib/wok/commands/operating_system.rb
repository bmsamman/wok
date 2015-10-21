require 'pp'
require 'fileutils'

def cd *args
  args[0] = "~" if args.empty?
  args[0] = File.expand_path(args[0])
  FileUtils.cd *args
end

def ls args=""
  system "ls #{args}"
end
