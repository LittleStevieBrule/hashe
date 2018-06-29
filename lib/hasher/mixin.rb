# @author Stephen McGuckin <stephendmcguckin@gmail.com>
module Hasher
  # A mixin used for including into a class
  #   @example
  #     class MyCustomHash
  #       include Mixin
  #     end
  #
  #   hash = MyCustomHash.new
  #   hash.foo = 'bar' # 'bar'
  #   hash[:baz] = 'qux' # 'qux'
  #   hash # {foo: 'bar', baz: 'qux'}
  module Mixin
    include Enumerable

    SETTER_PATTERN = /^([a-zA-Z_]+|\[\])=$/

    # @param default [Hash] default hash
    def initialize(default = {})
      @data = default
    end

    def each(&blk)
      @data.each(&blk)
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      @data[key.to_sym] = value
    end

    def inspect
      @data.to_s
    end

    alias to_s inspect

    def method_missing(name, *args, &blk)
      return @data.send(name, *args, &blk) if @data.respond_to?(name)
      if SETTER_PATTERN =~ name
        new_attribute(name.to_s.delete('='))
        return send(name, args[0])
      end
      super
    end

    def respond_to_missing?(name, *args)
      @data.respond_to?(name) || super
    end

    private

    def new_attribute(key)
      key = key.to_sym
      raise 'method already defined' if @data.respond_to?(key)
      setter = "#{key}="
      define_singleton_method(setter) { |v| @data[key] = v }
      define_singleton_method(key) { @data[key] }
    end
  end
end
