$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "zoho/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zoho"
  s.version     = Zoho::VERSION
  s.authors     = ["Saurabh gulati"]
  s.email       = ["saurabhgulati159@gmail.com"]
  s.homepage    = "https://dron-new.herokuapp.com"
  s.summary     = "Summary of Zoho."
  s.description = "Description of Zoho."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # s.add_dependency "rails", "~> 5.2.1"
  s.add_dependency "rspec"
  s.add_development_dependency "sqlite3"
end
