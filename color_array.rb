class ColorArray
  attr_accessor :colors, :config, :leds_per_row

  def initialize(config)
    @config = config
    @colors = Array.new(config.led_count) { '#000000' }
    @leds_per_row = config.leds_per_block * config.columns
  end

  def set_color(row, column, color)
    first_led = row_start_led(row) + config.leds_per_block * column
    last_led = first_led + config.leds_per_block
    colors[first_led..last_led] = Array.new(config.leds_per_block) { color }
  end

  def to_s
    @colors
  end

  private

  def row_start_led(row)
    leds_per_row * row
  end
end
