require 'representable/json/hash'

class ErrorsRepresenter < Representable::Decorator
  include Representable::JSON::Hash
  self.representation_wrap = :errors
end
