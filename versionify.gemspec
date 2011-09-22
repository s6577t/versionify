# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "versionify/version"

Gem::Specification.new do |s|
  s.name        = "versionify"
  s.version     = Versionify::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sam Taylor"]
  s.email       = ["sjltaylor@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{versioning functionality}
  #s.description = %q{TODO: Write a gem description}
  
  s.add_dependency 'rake', '>=0.9.2'
  s.rubyforge_project = "versionify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
