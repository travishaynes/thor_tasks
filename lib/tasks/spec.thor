class Spec < Thor
  include Thor::Actions
  
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
    run "#{b} rspec spec/routing/#{name}_spec.rb"
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
    available_types = [
      'controllers', 'helpers', 'models', 'requests', 'routing', 'views'
    ]
    if options[:help]
      puts "Available types for thor spec:list are"
      available_types.each do |t|
        puts "  #{t}"
      end
      puts "Running thor spec:list without specifying a type will list all specs from all types."
      return
    end
    
    Dir["spec/#{name}/*_spec.rb"].each do |f|
      f = f.split("_")[0]
      f = name == "*" ? f.partition("/")[2] : f.gsub("spec/#{name}/", "")
      puts "  #{f}"
    end
  end
end
