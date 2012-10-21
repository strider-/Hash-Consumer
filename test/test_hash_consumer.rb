require 'test/unit'
require 'hash_consumer'

class HashConsumerTest < Test::Unit::TestCase
  @@test_hash = {'float' => 1.3, 'bool' => true, :sym_key => :sym_value,
                'nested' => { '123_number_key' => 'string_value', 'i!!3g@l_n4m!ng' => true } }      
  
  def test_consumation
    consumed = @@test_hash.consume
    assert_not_nil consumed
  end

  def test_method_creation
    consumed = @@test_hash.consume
    assert_equal @@test_hash['bool'], consumed.bool
  end

  def test_symbol_keys
    consumed = @@test_hash.consume
    assert_equal @@test_hash[:sym_key], consumed.sym_key
  end

  def test_dynamic_methods_call
    consumed = @@test_hash.consume
    assert consumed.dynamic_methods.include?(:float)
  end

  def test_nested_hashes
    consumed = @@test_hash.consume
    assert_equal @@test_hash['nested'].keys.length, consumed.nested.dynamic_methods.length
  end

  def test_keys_starting_with_digits
    consumed = @@test_hash.consume
    assert_equal @@test_hash['nested']['123_number_key'], consumed.nested._123_number_key
  end

  def test_keys_with_invalid_method_name_characters
    consumed = @@test_hash.consume
    assert_equal @@test_hash['nested']['i!!3g@l_n4m!ng'], consumed.nested.i__3g_l_n4m_ng
  end

  def test_respects_indexer
    consumed = @@test_hash.consume
    assert_equal @@test_hash['float'], consumed['float']
  end

  def test_whiny_nils_on
    HashConsumer.whine_on_missing_methods = true
    consumed = @@test_hash.consume
    assert_raise NoMethodError do
      consumed.this_method_doesnt_exist
    end
  end

  def test_whiny_nils_off
    HashConsumer.whine_on_missing_methods = false
    consumed = @@test_hash.consume
    assert_nothing_raised do
      consumed.this_method_doesnt_exist
    end
  end
end
