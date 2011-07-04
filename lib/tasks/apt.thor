require 'rainbow'

class Apt < Thor
  include Thor::Actions
  
  map "s" => :search,
      "w" => :show 
  
  desc "search \"terms\"", "runs apt-cache search and pretty-prints the output"
  def search(terms)
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
      # print the name in bright yellow
      print "#{k}".foreground(:yellow).bright
      # pad the names with spaces
      print "#{" " * (longest - k.length)}"
      # print the description in green
      print "  #{v}\n".foreground(:white).bright
    end
    # restore the terminal color
    print "".reset
  end
  
  desc "show \"package\" [--desc]", "cleans up apt-cache show output for a package"
  method_option :desc, :type => :boolean, :aliases => "-d" # shows only the description
  def show(package)
    # get the apt-cache show output
    output = `apt-cache show \"#{package}\"`.split("\n")
    return false if output.length == 0
    # we will split this into 3 parts: parameters, description, and footnote
    params = {}
    desc = ""
    ftn = nil
    # iterate through each line
    output.each do |l|
      # unless the first character is a space, we have a parameter
      unless l[0] == " "
        # get the name - before the first colon
        p = l.partition(":")
        # get the value
        params[p[0]] = p[2].strip
      else
        # if the line is a space and a period, we are entering the footnote
        if l == " ." # footnote
          # toggle the footnote
          ftn = ""
        else
          # add to the description, unless we are in the footnote
          desc += l.strip if ftn.nil?
          # add to teh footnote, unless we are in the description
          ftn += l.strip unless ftn.nil?
        end
      end
    end
    # find the longest key in the parameters
    longest = 0
    params.each do |k,v|
      longest = k.length > longest ? k.length : longest
    end
    
    # start by printing the description parameter (title of the package)
    print params["Description"].foreground(:green).bright.underline + "\n\n"
    
    # print the long description
    print desc.foreground(:white).bright + "\n\n"
    # print the footnote
    print ftn.foreground(:blue) + "\n\n"
    
    # ommit the details if we only want the description
    unless options[:desc]
      params.each do |k,v|
        print_param(params, k, longest)
      end
      puts "\n"
    end
  end
  
  no_tasks do
    def print_param(params, name, longest)
      unless params[name].nil?
        print "#{name}  ".foreground(:blue).bright
        print " " * (longest - name.length)
        print params[name].foreground(:green) + "\n"
      end
    end
  end
end
