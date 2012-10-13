# HashConsumer

Consumes a Ruby hash and returns a object that has the hash keys as methods.  Works recursively and with arrays.
Has a dependency on rails/active_support.

Example:

    consumed_hash = {
                       :name => "Some Guy", 
                       :nested => { 
                         :bool => true, 
                         "string_key" => "yup"
                       }, 
                       "123" => "numbers get underscore prefixed" 
                    }.consume

    consumed_hash.name        # Some Guy
    consumed_hash.nested.bool # true
    consumed_hash._123        # numbers get underscore prefixed
    consumed.dynamic_methods  # returns an array of all methods created for this object
    consumed[:nested]         # respects indexer so it can act as a hash

# Options
  
  Raise exceptions or return nil when accessing methods that don't exist.  Defaults to false.

    HashConsumer.whine_on_missing_methods = (true | false)    

# Notes
  
  to_s, to_json & as_json return the respective values of the underlying hash