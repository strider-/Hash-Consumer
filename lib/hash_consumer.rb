require "hash_consumer/version"
require "active_support"
require "active_support/inflector"
require "extensions"

class HashConsumer
  attr_reader :dynamic_methods
  @@whine = false
  @base_hash = nil

  def initialize(hash)
    raise ArgumentError "Only hashes are supported." unless hash.is_a? Hash

    @dynamic_methods = hash.keys.map { |k| safe_key(k).to_sym }
    @base_hash = hash

    @base_hash.each do |k,v|
      method_name = safe_key(k)
      define_singleton_method method_name, lambda { resolve_value(v) }
    end
  end

  def self.whine_on_missing_methods
    @@whine
  end

  def self.whine_on_missing_methods=(bool)
    @@whine = bool
  end  

  def to_s
    @base_hash.to_s
  end

  def to_json(options = {})
    @base_hash.to_json options
  end

  def as_json(options = {})
    @base_hash.as_json options
  end

  def method_missing(name, *args)
    @@whine ? super : nil
  end

  private
    def safe_key(key)
      result = key.to_s.underscore
      result.prepend('_') if result =~ /^\d/
      result
    end

    def resolve_value(value)
      if value.is_a?(Hash) 
        HashConsumer.new(value)
      elsif value.is_a?(Array)
        value.map { |a| resolve_value(a) }
      else
        value
      end      
    end
end
