# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "thor_tasks/version"

Gem::Specification.new do |s|
  s.name        = "thor_tasks"
  s.version     = ThorTasks::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Travis Haynes"]
  s.email       = ["travis.j.haynes@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Some helpful thor tasks}
  s.description = %q{A collection of helpful thor tasks to use in Ruby on Rails projects.}

  s.rubyforge_project = "thor_tasks"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
