Gem::Specification.new do |s|
  s.name = 'logstash-filter-naxsi'
  s.version         = '0.9.2'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter plugin will split a naxsi event into multiple in conjunction with other filters."
  s.description = ""
  s.authors = ["NextGxDx"]
  s.email = 'engineering@nextgxdx.com'
  s.homepage = "https://github.org/nextgxdx/logstash-filter-naxsi"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','Gemfile','LICENSE']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0.0", "< 3.0.0"
  s.add_development_dependency 'logstash-devutils'
  s.add_development_dependency "concurrent-ruby", "0.9.1"
end
