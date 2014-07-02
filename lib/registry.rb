require "registry/version"

def Registry(klass)
  klass.extend Registry::ClassMethods
end

class Registry < Hash
  module ClassMethods
    def register(*args, &block)
      registry.register(*args, &block)
    end

    def registry
      @registry ||= Registry.new
    end

    def reset!
      @registry = Registry.new
    end
  end

  def register(key, *values, &block)
    values << block if block_given?
    values = values.first if values.count < 2
    self[key] = values
  end
end
