source 'https://rubygems.org'

gem 'rails',        '~> 5.2.3'
gem 'rails-i18n'
gem 'bcrypt'
gem 'faker'
gem 'bootstrap-sass'
gem 'will_paginate' 
gem 'bootstrap-will_paginate'
gem 'mini_magick',  '~> 4.8'
gem 'payjp'
gem "aws-sdk-s3", require: false
gem 'puma',         '~> 4.3'
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',   '~> 5'
gem 'jbuilder',     '~> 2.5'
gem 'bootsnap'
gem 'activestorage', '~> 5.2.0'
gem 'dotenv-rails'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

group :production do
  gem 'pg', '0.20.0'
  gem 'rails_12factor'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
# Mac環境でもこのままでOKです
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]