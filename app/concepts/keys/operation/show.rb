module Keys::Operation
  class Show < Trailblazer::Operation
    step ->(options, params) { options["representer.render.class"] = Keys::Representer::Create }
    step :model!
    step :environments!
    step :node!
    step :node_data!
    step :nodes!

    def model!(opts, params:, current_user:, **)
      opts[:model] = OpenStruct.new(
        id: params[:id]
      )
    end

    def environments!(opts, params:, current_user:, **)
      opts[:view] = {}
      opts[:view][:environment] = Environment.new(params[:environment_id])
      opts[:view][:environments] = Environment.all
    end

    def node!(opts, params:, **)
      opts[:view][:node] = Node.new(params[:node_id])
    end

    def node_data!(opts, params:, **)
      opts[:hiera] = Hiera.new(params[:environment_id])
      opts[:view][:key_data] = opts[:hiera].search_key(params[:node_id], params[:id])
      opts[:view][:node_data] = opts[:hiera].all_keys(params[:node_id])
    end

    def nodes!(opts, params:, current_user:, **)
      opts[:view][:nodes] = Node.all
    end
  end
end
