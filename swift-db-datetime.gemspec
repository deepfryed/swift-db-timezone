# -*- encoding: utf-8 -*-
# stub: swift-db-datetime 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "swift-db-datetime"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bharanee Rathna"]
  s.date = "2015-03-22"
  s.description = "Swift db adapter datetime & timezone helper"
  s.email = ["deepfryed@gmail.com"]
  s.files = ["CHANGELOG", "README.md", "lib/swift/db/timezone.rb", "test/helper.rb", "test/test_timezone.rb"]
  s.homepage = "http://github.com/deepfryed/swift-db-datetime"
  s.rubygems_version = "2.2.0"
  s.summary = "Swift db adapter datetime & timezone helper"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<swift-db-sqlite3>, [">= 0"])
      s.add_development_dependency(%q<minitest-reporters>, [">= 0"])
    else
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<swift-db-sqlite3>, [">= 0"])
      s.add_dependency(%q<minitest-reporters>, [">= 0"])
    end
  else
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<swift-db-sqlite3>, [">= 0"])
    s.add_dependency(%q<minitest-reporters>, [">= 0"])
  end
end
