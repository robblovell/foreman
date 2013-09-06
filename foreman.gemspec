$:.unshift File.expand_path("../lib", __FILE__)
require "foreman/version"

Gem::Specification.new do |gem|
  gem.name     = "foreman-robb"
  gem.license  = "MIT"
  gem.version  = Foreman::VERSION

  gem.author   = "David Dollar with stupid mod from Robb Lovell"
  gem.email    = "ddollar@gmail.com"
  gem.homepage = "http://github.com/ddollar/foreman"
  gem.summary  = "Process manager for applications with multiple components (with upstart export restart delay)"

  gem.description = gem.summary

  gem.executables = "foreman"
  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }
  gem.files << "man/foreman.1"

  gem.add_dependency 'thor', '>= 0.13.6'
  gem.add_dependency 'dotenv', '>= 0.7'

  if ENV["PLATFORM"] == "java"
    gem.platform = Gem::Platform.new("java")
  end

  if ENV["PLATFORM"] == "mingw32"
    gem.add_dependency "win32console", "~> 1.3.0"
    gem.platform = Gem::Platform.new("mingw32")
  end
end
