class Apt < Thor
  include Thor::Actions
  
  map "s" => :search
  
  desc "search \"terms\"", "runs apt-cache search and pretty-prints the output"
  def search(terms)
    # attempt to load rainbow for pretty-print 
    begin
      require 'rainbow'
      pp = true
    rescue GEM::LoadError
      pp = false
    end
    # run apt-cache search
    results = `apt-cache search "#{terms}"`.split("\n")
    # create a Hash out of the results
    results = results.inject({}) { |r,k| r[k.partition(" - ")[0]] = k.partition(" - ")[2]; r }
    # find the longest key
    longest = 0
    results.each do |k,v|
      longest = k.length > longest ? k.length : longest
    end
    # pretty print the results
    results.each do |k,v|
      if pp
        # print the name in bright yellow
        print "#{k}".foreground(:yellow).bright
        # pad the names with spaces
        print "#{" " * (longest - k.length)}"
        # print the description in green
        print "  #{v}\n".foreground(:white).bright
      else
        # print the name, padding, and description
        puts "#{k + " " * (longest - k.length) + "  " + v}"
      end
    end
    # restore the terminal color
    print "".reset
  end
end
