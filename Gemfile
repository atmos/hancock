source :gemcutter

do_version = '~>0.10.1'
dm_version = '~>0.10.2'

group :runtime do
  gem 'dm-core',        dm_version
  gem 'extlib',         '~>0.9.14'
  gem 'sinatra',        '~>1.0'
  gem 'haml',           '~>3.0.0'
  gem 'do_sqlite3',     do_version
  gem 'dm-validations', dm_version
  gem 'dm-timestamps',  dm_version
  gem 'dm-aggregates',  dm_version
  gem 'dm-migrations',  dm_version
  gem 'dm-types',       dm_version
  gem 'ruby-openid',    '~>2.1.7'
  gem 'guid',           '~>0.1.1'
  gem 'rack-contrib',   '~>0.9.2'
  gem 'json'
end

group :test do
  gem 'rack-test',      '~>0.5.0',  :require => 'rack/test'
  gem 'webrat',         '~>0.7.0'
  gem 'rspec',          '~>1.2.9',  :require => 'spec'
  gem 'rake'
  gem 'rcov'
  gem 'cucumber',       '~>0.5.1'
  gem 'dm-sweatshop',   dm_version
  gem 'randexp'
  gem 'ParseTree',                  :require => 'parse_tree'
  gem 'bundler',        '~>0.9.24'
end
