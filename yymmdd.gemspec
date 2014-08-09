require File.expand_path("../lib/yymmdd", __FILE__)
require "date"

Gem::Specification.new do |s|
  s.name        = "yymmdd"
  s.version     = YYMMDD::VERSION
  s.date        = Date.today
  s.summary     = "Small DSL for idiomatic date parsing and formatting"
  s.description =<<-DESC
    Small DSL for idiomatic parsing and formatting of numeric date components.
  DESC
  s.authors     = ["Skye Shaw"]
  s.email       = "skye.shaw@gmail.com"
  s.test_files  = Dir["test/**/*.*"]
  s.extra_rdoc_files = %w[README.md]
  s.files       = Dir["lib/**/*.rb"] + s.test_files + s.extra_rdoc_files
  s.homepage    = "http://github.com/sshaw/yymmdd"
  s.license     = "MIT"
  s.add_development_dependency "rake", "~> 0.9"
end
