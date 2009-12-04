do_version = '~>0.10.0'
dm_version = '~>0.10.1'

gem 'dm-core',          dm_version

only :release do
  gem 'sinatra',        '~>0.9.0' 
  gem 'haml',           '~>2.2.0' 
  gem 'do_sqlite3',     do_version
  gem 'dm-validations', dm_version
  gem 'dm-timestamps',  dm_version
  gem 'dm-types',       dm_version
  gem 'ruby-openid',    '~>2.1.7'
  gem 'guid',           '~>0.1.1'
  gem 'rack-contrib',   '~>0.9.2'
  gem 'json'
end

only :test do
  gem 'rack-test',      '~>0.5.0',  :require_as => 'rack/test'
  gem 'webrat',         '~>0.5.0'
  gem 'rspec',          '~>1.2.9',  :require_as => 'spec'
  gem 'rake'
  gem 'rcov'
  gem 'cucumber'
  gem 'dm-aggregates',  dm_version
  gem 'dm-sweatshop',   dm_version
  gem 'randexp'
  gem 'ParseTree',                  :require_as => 'parse_tree'
  gem 'bundler',        '>=0.7.0'
end

disable_system_gems
