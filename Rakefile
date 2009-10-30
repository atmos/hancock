require File.join(File.dirname(__FILE__), 'vendor', 'gems', 'environment')
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'bundler'

GEM = "hancock"
GEM_VERSION = "0.1.0"
AUTHOR = ["Corey Donohoe", "Tim Carey-Smith"]
EMAIL = [ "atmos@atmos.org", "tim@spork.in" ]
HOMEPAGE = "http://github.com/atmos/hancock"
SUMMARY = "A gem that provides a Single Sign On server"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  manifest = Bundler::Environment.load(File.dirname(__FILE__) + '/Gemfile')
  manifest.dependencies.each do |d|
    next if d.only && d.only.include?('test')
    s.add_dependency(d.name, d.version)
  end

  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{features,lib,spec}/**/*")
end
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

task :default => [:spec, :cucumber]

require 'spec/rake/spectask'
desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fp --color)

  t.rcov = true
  t.rcov_opts << '--text-summary'
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  t.rcov_opts << '--exclude' << '.gem/,spec,examples'
  #t.rcov_opts << '--only-uncovered'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.libs << 'lib'
  t.cucumber_opts = "--format pretty"
  t.rcov = true
  t.rcov_opts << '--text-summary'
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
  t.rcov_opts << '--exclude' << '.gem/,spec,features,examples'
end
