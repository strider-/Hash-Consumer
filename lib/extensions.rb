require 'hash_consumer'

# Adding consume extension method on Hash
class Hash
  def consume
    HashConsumer.new self
  end
end