# frozen_string_literal: true

class Currency
  attr_reader :value

  ALL = [1, 5, 10, 50, 100, 500, 1000, 2000, 5000, 10_000].freeze

  def initialize(value)
    @value = value if ALL.member?(value)
    raise ArgumentError unless @value
  end

  def to_s
    "#{value}円#{value >= 1000 ? '札' : '玉'}"
  end
end
