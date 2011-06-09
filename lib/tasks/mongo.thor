class Mongo < Thor
  include Thor::Actions
  
  desc "start", "starts mongodb"
  def start
    if mongod_pid.nil?
      puts "Starting MongoDB . . ."
      run 'sudo mongod --dbpath /var/lib/mongodb --fork --logpath /var/log/mongodb.log --logappend'
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
  
  private
  
  def mongod_pid
    `pidof mongod`.split("\n").first
  end
  
end
