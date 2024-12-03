class Cache
  def initialize(limit)
    @limit = limit
    @cache = {}
    @order = []
  end

  def get(key)
    return nil unless @cache.key?(key)
    @order.delete(key)
    @order.push(key)
    @cache[key]
  end

  def set(key, value)
    if @cache.size >= @limit
      oldest_key = @order.shift
      @cache.delete(oldest_key)
    end
    @cache[key] = value
    @order.push(key)
  end
end

class SquareNum
  def initialize(cache)
    @cache = cache
  end

  def square(number)
    result = @cache.get(number)
    return result if result # якщо кешовано, то повертаємо результат

    # Якщо немає в кеші, обчислюємо і зберігаємо
    result = number ** 2
    @cache.set(number, result)
    result
  end
end

c = Cache.new(3)
s = SquareNum.new(c)

puts s.square(2)  # вперше
puts s.square(3)  # вперше
puts s.square(4)  # вперше
puts s.square(2)  # кеш
puts s.square(5)  # вперше
puts s.square(3)  # кеш

puts s.square(5)  # з кешу
puts s.square(2)  # обчислюється знову, було видалено з кешу так як перевищено ліміт
