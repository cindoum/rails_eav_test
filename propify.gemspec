$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "propify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "propify"
  s.version     = Propify::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Propify."
  s.description = "TODO: Description of Propify."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"

  s.add_development_dependency "sqlite3"
end
