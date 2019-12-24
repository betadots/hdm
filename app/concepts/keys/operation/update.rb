module Keys::Operation
  class Update < Trailblazer::Operation
    include Model
    step ->(options, params) { options["representer.render.class"] = Keys::Representer::Create }
    step ->(options, params) { options["representer.errors.class"] = ErrorsRepresenter }

    step Nested( Keys::Operation::Show )
    # TODO: Update trb 2.1
    step ->(options, params) { options['model'] = options[:model] }
    step Contract::Build(constant: Keys::Contract::Update)
    step Contract::Validate(key: "key")
    step :save_on_file!

    def save_on_file!(ctx, params:, **)
      path = params[:key][:path]
      value = YAML.load(params[:key][:value])
      key = params[:id]
      ctx[:hiera].write_key(path, key, value)
      true
    end
  end
end
