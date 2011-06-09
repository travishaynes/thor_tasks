class Spec < Thor
  include Thor::Actions
  
  desc "controller [NAME]", "runs rspec for controllers"
  def controller(name="*")
    run "rspec spec/controllers/#{name}_controller_spec.rb"
  end
  
  desc "helper [NAME]", "runs rspec for helpers"
  def helper(name = "*")
    run "rspec spec/helpers/#{name}_helper_spec.rb"
  end

  desc "model [NAME]", "runs rspec for models"
  def model(name = "*")
    run "rspec spec/models/#{name}_spec.rb"
  end
  
  desc "request [NAME]", "runs rspec for requests"
  def request(name = "*")
    run "rspec spec/requests/#{name}_spec.rb"
  end
  
  desc "routing [NAME]", "runs rspec for routing"
  def routing(name = "*")
    run "rspec spec/routing/#{name}_spec.rb"
  end
  
  desc "view [CONTROLLER] [ACTION]", "runs rspec for views"
  def view(controller = "*", action = "*")
    run "rspec spec/views/#{controller}/#{action}*_spec.rb"
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
