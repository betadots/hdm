module Keys::Operation
  class Create < Trailblazer::Operation
    include Model
    step ->(options, params) { options["representer.render.class"] = Keys::Representer::Create }
    step ->(options, params) { options["representer.errors.class"] = ErrorsRepresenter }

    step Nested( Keys::Operation::Show )
    # TODO: Update trb 2.1
    step ->(options, params) { options['model'] = options[:model] }
    step Contract::Build(constant: Keys::Contract::Create)
    step Contract::Validate(key: "key")
    step :save_on_file!
    failure :fail!

    def save_on_file!(ctx, params:, **)
      # value = YAML.load(params[:key][:value])
      key = params[:id]
      ctx[:hiera].write_key("common.yaml", key, '')
      true
    end

    def fail!(ctx, params:, **)
      require 'pry'; binding.pry
    end
  end
end
