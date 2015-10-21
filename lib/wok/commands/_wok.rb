def wprint str
  puts str
end

def system *args
  if $dry
    wprint args[0]
  else
    wprint Kernel.system *args
  end
end
alias :cmd :system

def check_path path
  raise "Check path failed: #{path}" unless File.exist? path
end

def check_bin bin
  raise "Check bin failed: #{bin}" if `which #{bin}`.empty?
end

def kill bin
  cmd "pkill #{bin}"
end

def echo str
  wprint str
end

def yes? str
  wprint str + "(Y/N)"
  return true if %w{Y y yes Yes YES}.include? gets
  return false if %w{N n no No NO}.include? gets
  yes? str
end