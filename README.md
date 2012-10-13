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
