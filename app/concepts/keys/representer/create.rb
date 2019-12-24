module Keys::Representer
  module Create
    include Representable::JSON
    include OpenStructModule
  end
end
