# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "platform_automation"
  spec.version       = '1.0'
  spec.authors       = ["Alex Plotitsa"]
  spec.email         = ["aplotitsa@apigee.com"]
  spec.summary       = %q{Test Automation for Insights Platform}
  spec.description   = %q{Automate testcases for Insights Platform.}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = "MIT"
  spec.files         = ['lib/platform_automation.rb']
  spec.executables   = ['bin/platform_automation']

  spec.test_files    = ['tests/test_platform_automation.rb']
  spec.require_paths = ["lib"]
end
