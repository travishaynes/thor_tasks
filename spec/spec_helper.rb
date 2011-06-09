require 'thor'

Dir["lib/tasks/*.thor"].each { |ext| load ext } if defined?(Thor)
