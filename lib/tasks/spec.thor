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
end
