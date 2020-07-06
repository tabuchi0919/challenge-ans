# frozen_string_literal: true

class Cart
  extend Forwardable

  attr_reader :content

  def_delegators :content, :empty?

  def initialize
    @content = Hash.new(0)
  end

  def add(name)
    good = Good.find(name)
    if good
      @content[good] += 1
      true
    else
      false
    end
  end

  def to_money
    Money.new(
      content.sum do |good, cnt|
        good.price * cnt
      end
    )
  end

  def to_s
    receipt = content.map do |good, cnt|
      [
        "#{good.kana} * #{cnt}",
        "#{good.price * cnt}ｴﾝ"
      ]
    end
    max_length1 = receipt.map { _1[0].length }.max
    max_length2 = receipt.map { _1[1].length }.max

    [
      "+#{'-' * (max_length1 + max_length2 + 1)}+",
      receipt.map do
        "|#{_1.ljust(max_length1)} #{_2.rjust(max_length2)}|"
      end,
      "+#{'-' * (max_length1 + max_length2 + 1)}+"
    ].join("\n")
  end
end
