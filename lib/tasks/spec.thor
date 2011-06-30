class Spec < Thor
  include Thor::Actions
  
  map "a" => :all,
      "c" => :controller,
      "h" => :helper,
      "l" => :list,
      "m" => :model,
      "t" => :request,
      "r" => :routing,
      "v" => :view
  
  no_tasks do
    def available_types
      ['controllers', 'helpers', 'models', 'requests', 'routing', 'views']
    end
  end

  desc "all", "runs all your specs"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def all
    b = options[:bundle] ? "bundle exec" : ""
    run "rspec spec"
  end
  
  desc "controller [NAME]", "runs rspec for controllers"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def controller(name="*")
    b = options[:bundle] ? "bundle exec" : ""
    run "#{b} rspec spec/controllers/#{name}_controller_spec.rb"
  end
  
  desc "helper [NAME]", "runs rspec for helpers"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def helper(name = "*")
    b = options[:bundle] ? "bundle exec" : ""
    run "#{b} rspec spec/helpers/#{name}_helper_spec.rb"
  end

  desc "model [NAME]", "runs rspec for models"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def model(name = "*")
    b = options[:bundle] ? "bundle exec" : ""
    run "#{b} rspec spec/models/#{name}_spec.rb"
  end
  
  desc "request [NAME]", "runs rspec for requests"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def request(name = "*")
    b = options[:bundle] ? "bundle exec" : ""
    run "#{b} rspec spec/requests/#{name}_spec.rb"
  end
  
  desc "routing [NAME]", "runs rspec for routing"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def routing(name = "*")
    b = options[:bundle] ? "bundle exec" : ""
    run "#{b} rspec spec/routing/#{name}_routing_spec.rb"
  end
  
  desc "view [CONTROLLER] [ACTION]", "runs rspec for views"
  method_option :bundle, :type => :boolean, :aliases => "-b"
  def view(controller = "*", action = "*")
    b = options[:bundle] ? "bundle exec" : ""
    run "#{b} rspec spec/views/#{controller}/#{action}*_spec.rb"
  end
  
  desc "list [TYPE}]", "lists specs for TYPE, see thor spec:list --help for more info."
  method_options :help => false
  def list(name = "*")
    if options[:help]
      puts "Available types for thor spec:list are"
      available_types.each do |t|
        puts "  #{t}"
      end
      puts "Running thor spec:list without specifying a type will list all specs from all types."
      return
    end
    
    paths = Dir["spec/#{name}/**/"].sort.reject { |p| p if !available_types.include?(p.split("/")[1]) }
    paths.each do |p|
      path = p.split("/")
      l = path.length
      # the following prints an indented path in a color that is relative to the
      # levels of indentation
      print "#{'  ' * (l-2)}\x1b[38;5;1#{l-1}m#{path[l-1]}\x1b[0m\n"
      files = Dir["#{p}*_spec.rb"].sort
      files.each do |f|
        spec = File.basename(f, "_spec.rb")
        spec = spec.rpartition("_")[0] if ['controllers', 'helpers', 'routing'].include? path[1]
        print "#{'  ' * (l-1)}#{spec}\n" # prints the spec with indentation
      end
      print "\n" unless files.length == 0
    end
  end
end
