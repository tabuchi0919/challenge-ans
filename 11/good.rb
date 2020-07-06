# frozen_string_literal: true

class Good
  attr_reader :name, :price, :kana

  class << self
    def all
      JSON.parse(File.read('goods.json')).values.flatten.map { new(_1) }
    end

    def find(name)
      all.find { _1.name == name }
    end
  end

  def initialize(attributes)
    @name = attributes['name']
    @price = attributes['price']
    @kana = attributes['kana']
  end

  def hash
    to_h.hash
  end

  def eql?(other)
    return false unless other.is_a?(self.class)

    to_h.eql?(other.to_h)
  end

  protected

  def to_h
    {
      name: name,
      price: price,
      kana: kana
    }
  end
end
