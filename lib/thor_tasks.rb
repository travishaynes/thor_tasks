require 'rails'
require 'rails/generators'

module ThorTasks

  class InstallGenerator < Rails::Generators::Base
    desc "Installs thor tasks into your Rails application."

    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'tasks'))
    end

    def copy_tasks
      copy_file "spec.thor", "lib/tasks/spec.thor"
      copy_file "spork.thor", "lib/tasks/spork.thor"
      copy_file "cucumber_spork.thor", "lib/tasks/cucumber_spork.thor"
    end
  end

end
