require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'spec/rake/spectask'

GEM = "hancock"
GEM_VERSION = "0.0.1"
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

  # Uncomment this to add a dependency
  s.add_dependency "dm-core", "~>0.9.10"
  s.add_dependency "ruby-openid", "~>2.1.2"
  s.add_dependency "sinatra", "~>0.9.1"
  s.add_dependency "guid", "~>0.1.1"

  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{lib,spec}/**/*")
end

task :default => :spec
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

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
