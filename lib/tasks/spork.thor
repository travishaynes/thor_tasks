class Spork < Thor
  include Thor::Actions
  
  desc "start", "starts Spork in the background"
  def start
    run "(bundle exec spork &)"
  end
  
  desc "stop", "stops Spork"
  def stop
    Process.kill(:TERM, `ps -ef | grep spork | grep -v grep | awk '{ print $2 }'`.to_i)
  end
  
  desc "restart", "restarts Spork"
  def restart
    invoke :stop
    invoke :start
  end
end
