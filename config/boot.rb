ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

# Fix for Rails 4.2.3 on Ruby 2.7+ - BigDecimal.new is removed in newer Ruby
require 'bigdecimal'
unless BigDecimal.respond_to?(:new)
  class BigDecimal
    def self.new(value, ndig=0)
      BigDecimal(value, ndig)
    end
  end
end

require 'bundler/setup' # Set up gems listed in the Gemfile.
