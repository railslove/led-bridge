require 'json'
require 'rack'
require 'yaml'

require_relative 'color_array'
require_relative 'lib/led_strip' if Gem::Specification.find_all_by_name('ws2812').any?

def config
  OpenStruct.new YAML.load_file('config.yml')
end

def process_request(request_data, color_array)
  request_data.each do |row_index, row_data|
    row_data.each do |column_index, color|
      color_array.set_color row_index.to_i, column_index.to_i, color
    end
  end

  color_array
end

run -> (env) {
  data = JSON.parse(Rack::Request.new(env).body.read)

  color_array = ColorArray.new config
  process_request data, color_array

  # only if gem is available
  if Gem::Specification.find_all_by_name('ws2812').any?
    strip = LedStrip.new config.led_count, config.led_pin
    strip.colors color_array.colors
  end

  Rack::Response.new({ status: 'ok', data: color_array.colors }.to_json, 200, 'Content-Type' => 'application/json')
}
