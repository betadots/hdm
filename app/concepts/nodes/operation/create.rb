module Nodes::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step ->(options, params) { options["representer.render.class"] = Nodes::Representer::Create }
      step ->(options, params) { options["representer.errors.class"] = Reativo::Representer::Errors }
      step Model(OpenStruct, :new)
      step Contract::Build( constant: Nodes::Contract::Create )
    end

    step Nested( Present )
    step Contract::Build(constant: Nodes::Contract::Create)
    step Contract::Validate(key: 'open_struct')
    step Contract::Persist()
  end
end
