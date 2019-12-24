module Environments::Representer
  module Create
    include Representable::JSON
    include OpenStructModule
  end
end
