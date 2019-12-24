module Editor::Representer
  module Index
    include Representable::JSON::Collection

    items class: OpenStruct do
      include Representable::JSON
      include OpenStructModule
    end
  end
end
