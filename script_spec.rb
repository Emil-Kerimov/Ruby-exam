require 'rspec'
require './script.rb'

RSpec.describe Cache do
  let(:cache) { Cache.new(3) }
  let(:square_num) { SquareNum.new(cache) }

  it 'повертає nil, якщо елемент не знайдено в кеші' do
    expect(cache.get(11)).to be_nil
  end

  it 'повертає з кешу, якщо там є кешований результат' do
    cache.set(2, 4)
    expect(cache.get(2)).to eq(4)
  end

  it 'додає нові елементи в кеш' do
    cache.set(3, 9)
    cache.set(4, 16)
    expect(cache.get(3)).to eq(9)
    expect(cache.get(4)).to eq(16)
  end

  it 'видаляє найстаріший елемент, коли кеш перевищує ліміт' do
    cache.set(1, 1)
    cache.set(2, 4)
    cache.set(3, 9)
    cache.set(4, 16)  # Вилучимо найстаріший елемент так як ліміт 3
    expect(cache.get(1)).to be_nil
    expect(cache.get(2)).to eq(4)
    expect(cache.get(3)).to eq(9)
    expect(cache.get(4)).to eq(16)
  end
end

RSpec.describe SquareNum do
  let(:cache) { Cache.new(3) }
  let(:square_num) { SquareNum.new(cache) }

  it 'повертає правильний результат при першому обчисленні' do
    expect(square_num.square(2)).to eq(4)
  end

  it 'повертає кешований результат,коли значення в кеші' do
    square_num.square(3)
    expect(square_num.square(3)).to eq(9)
  end

  it 'обчислює і кешує нові значення' do
    expect(square_num.square(6)).to eq(36)
    expect(square_num.square(7)).to eq(49)
    expect(square_num.square(6)).to eq(36)
  end

  it 'видаляє старі значення при перевищенні ліміту' do
    square_num.square(4)
    square_num.square(5)
    square_num.square(6)
    square_num.square(7)
    expect(square_num.square(4)).to eq(16) # тут видаляється 16  і обчислюється знову
    expect(square_num.square(5)).to eq(25)
    expect(square_num.square(6)).to eq(36)
    expect(square_num.square(7)).to eq(49)
  end
end