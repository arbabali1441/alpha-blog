source 'https://rubygems.org'

ruby '2.7.8'

# Fix BigDecimal for Ruby 2.7+
gem 'bigdecimal', '~> 1.3.5'

# Lock ffi to a version compatible with Ruby 2.7
gem 'ffi', '~> 1.12.2'

# Rails version
gem 'rails', '4.2.10'

# Authentication & pagination
gem 'bcrypt', '~> 3.1.7'
gem 'kaminari', '~> 1.2'    # Modern pagination

# Tagging and search functionality
gem 'acts-as-taggable-on', '~> 4.0'
gem 'ransack', '~> 1.8.10'

# Frontend & assets - Bootstrap 5 modern styling
# gem 'bootstrap', '~> 5.3.0'  # Temporarily disabled for testing
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

# Popper for Bootstrap dropdowns/tooltips
# gem 'popper_js', '~> 2.11.6'

# Documentation
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'sqlite3', '~> 1.3', '< 1.4'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  gem 'pg', '~> 0.18'
  gem 'rails_12factor'
end
