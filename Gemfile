
source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'json_builder'
gem 'simplecov', :require => false, :group => :test
gem 'has_permalink'
gem 'aws-s3'
gem 'aws-sdk'
gem 'paperclip'

gem "activeadmin", "~> 0.4.4"
gem 'debitech', :git => 'git://github.com/ebosrup/debitech.git'
gem 'sass-rails',   '~> 3.1.5' #can't be in :assets due to activeadmin

gem 'devise'
gem "cancan"
gem 'formtastic', '2.1.1' # 2.2.x breaks activeadmin
gem 'redcarpet'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'pry'
end

group :staging, :production do
	gem 'pg'
end

gem 'jquery-rails'
gem 'i18n-active_record', :require => false # i18n-active_record tries to access db before initialize which crash app in production if required here


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end

group :test, :development do
  gem 'jasmine'
end
