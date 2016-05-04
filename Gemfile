def linux_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /linux/ ? require_as : false
end

source 'https://rubygems.org'

gem 'colormath'

gem 'ws2812' if RUBY_PLATFORM =~ /linux/

group :test do
  gem 'rspec'
end
