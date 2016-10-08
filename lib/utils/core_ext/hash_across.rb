# -*- coding: utf-8 -*-
#
#

class Hash
  # keys で指定された各要素の値についてブロックで変換された結果を値とする新しい {Hash} を返す
  #
  # @example
  #   hash = { a: 1, b: 3, c: 5 }
  #   hash.acrosss(:a, :c) {|value| value + 1 }
  #   # => { a: 2, b: 3, c: 6 }
  #
  #   hash = { x: :name, y: :age }
  #   enum = hash.across :x, :y
  #   enum.each {|value| value.to_s }
  #   # => { x: "name", y: "age" }
  #
  # @param [Array<Object>] keys 変換対象の要素を指定する self のキー。
  #                        指定しなかった場合には全ての要素が対象となる。
  # @yield [value] 値の変換を行う
  # @yieldparam [Object] value 変換対象の値
  # @yieldreturn [Object] 変換結果
  # @return [Hash] 変換結果から生成された新しい {Hash}
  # @return [Enumerator] ブロックが指定されなかたった場合には {Enumerator} を返す
  # @since 0.1.2
  #
  def across(*keys)
    keys = each_keys if keys.length == 0

    if block_given?
      result = {}
      keys.each do |key|
        result[key] = yield self[key]
      end
      result
    else
      Enumerator.new(keys.length) do |y|
        result = {}
        keys.each do |key|
          result[key] = y.yield self[key]
        end
        result
      end
    end
  end

  # keys で指定された各要素の値についてブロックで変換された結果で破壊的に更新する
  #
  # @example
  #   hash = { a: 1, b: 3, c: 5 }
  #   hash.acrosss!(:a, :c) {|value| value + 1 }
  #   # => { a: 2, b: 3, c: 6 }
  #   hash
  #   # => { a: 2, b: 3, c: 6 }
  #
  # @param [Array<Object>] keys 変換対象の要素を指定する self のキー。
  #                        指定しなかった場合には全ての要素が対象となる。
  # @yield [value] 値の変換を行う
  # @yieldparam [Object] value 変換対象の値
  # @yieldreturn [Object] 変換結果
  # @return [Hash] self
  #
  def across!(*keys)
    if keys.length == 0
      each do |key, value|
        self[key] = yield value
      end
    else
      keys.each do |key|
        self[key] = yield self[key]
      end
    end
    self
  end
end
