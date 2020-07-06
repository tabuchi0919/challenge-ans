# frozen_string_literal: true

require 'forwardable'
require 'json'
require './cart.rb'
require './currency.rb'
require './money.rb'
require './good.rb'

PAYMENT = '会計'
SELECTION = Good.all.map(&:name).push(PAYMENT)
SELECT_SENTENCE = "#{SELECTION.join('、')}から選んでください"

puts '終わりたいときはctrl+cを押してね'

loop do
  puts '-----------------------------'
  cart = Cart.new
  loop do
    puts SELECT_SENTENCE

    s = gets.chomp
    break if s == PAYMENT

    if cart.add(s)
      puts "#{s}をカートに追加しました"
    else
      puts '正しく入力してください'
    end
  end

  if cart.empty?
    puts '何も選択されていません'
    next
  end

  puts cart

  money = cart.to_money
  money_with_tax = money.with_tax

  puts "税抜#{money} 税込#{money_with_tax}"

  loop do
    puts "#{money_with_tax}支払ってください(数字以外は0円とみなします)"

    payment = Money.new(gets.chomp)
    if payment < money_with_tax
      puts 'お金が足りません'
    else
      change = payment - money_with_tax
      puts "#{change.pretty_string} 計:#{change}のお返しとなります"
      puts 'お買い上げありがとうございました'
      break
    end
  end
end
