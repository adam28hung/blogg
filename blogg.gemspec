$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blogg/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blogg"
  s.version     = Blogg::VERSION
  s.authors     = ["adam28hung"]
  s.email       = ["ivseas@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of Blogg."
  s.description = "Description of Blogg."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "closure_tree", "~> 6.0.0"
  s.add_dependency "simple_form"
  s.add_dependency "kaminari"
  s.add_dependency "ransack"

  s.add_development_dependency "sqlite3"
end
