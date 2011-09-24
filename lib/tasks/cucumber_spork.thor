class CucumberSpork < Thor
  include Thor::Actions
  
  desc "start", "starts Spork Cucumber in the background"
  def start
    run "(bundle exec spork cucumber &)"
  end
  
  desc "stop", "stops Spork Cucumber"
  def stop
    Process.kill(:TERM, `ps -ef | grep "spork cucumber" | grep -v grep | awk '{ print $2 }'`.to_i)
  end
  
  desc "restart", "restarts Spork Cucumber"
  def restart
    invoke :stop
    invoke :start
  end
end
