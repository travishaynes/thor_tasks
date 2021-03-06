class Mongo < Thor
  include Thor::Actions
  
  DEFAULT_DB_PATH = "/var/lib/mongodb"
  DEFAULT_LOG_PATH = "/var/log/mongodb.log"
  
  desc "start [DBPATH] [LOGPATH]", "starts mongodb"
  method_option :dbpath, :type => :string, :default => DEFAULT_DB_PATH
  method_option :logpath, :type => :string, :default => DEFAULT_LOG_PATH
  def start
    if mongod_pid.nil?
      puts "Starting MongoDB . . ."
      run "sudo mongod --dbpath #{options[:dbpath]} --fork --logpath #{options[:logpath]} --logappend"
    else
      puts "MongoDB is already running!"
    end
  end
  
  desc "stop", "stops mongodb"
  def stop
    if mongod_pid.nil?
      puts "Could not find MongoDB process id. Is it running?"
    else
      puts "Stopping MongoDB . . ."
      Process.kill(:TERM, mongod_pid.to_i)
      sleep(0.5)
      puts mongod_pid.nil? ? "Done." : "Could not end MongoDB process!"
    end
  end
  
  desc "restart", "restarts mongodb"
  def restart
    invoke :stop
    sleep(0.5) # allow a little time for process to end
    invoke :start
  end
  
  desc "repair [DBPATH]", "runs a repair on all databases"
  method_option :dbpath, :type => :string, :default => DEFAULT_DB_PATH
  def repair
    run "sudo mongod --dbpath #{options[:dbpath]} --repair"
  end
  
  private
  
  def mongod_pid
    `pidof mongod`.split("\n").first
  end
  
end
