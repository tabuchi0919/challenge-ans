# frozen_string_literal: true

class Money
  include Comparable

  TAX = 1.1

  attr_reader :value

  def initialize(value)
    @value = Integer(value)
  rescue ArgumentError
    @value = 0
  end

  def pretty_string
    to_currecies.map do |k, v|
      "#{k}:#{v}枚"
    end.join('、')
  end

  def to_s
    "#{value}円"
  end

  def with_tax
    Money.new((value * TAX).round)
  end

  def -(other)
    Money.new(value - other.value)
  end

  protected

  def <=>(other)
    value <=> other.value
  end

  private

  def to_currecies
    tmp = value
    Currency::ALL.reverse.to_h do |c|
      cnt = tmp / c
      tmp %= c
      [Currency.new(c), cnt]
    end.filter { |_k, v| v.positive? }
  end
end
