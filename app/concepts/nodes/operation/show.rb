module Nodes::Operation
  class Show < Trailblazer::Operation
    step ->(options, params) { options["representer.render.class"] = Nodes::Representer::Create }
    step :model!
    step :environments!
    step :node_data!
    step :nodes!

    def model!(opts, params:, current_user:, **)
      opts[:model] = Node.new(params[:id])
    end

    def environments!(opts, params:, current_user:, **)
      opts[:view] = {}
      opts[:view][:environment] = Environment.new(params[:environment_id])
      opts[:view][:environments] = Environment.all
    end

    def node_data!(opts, params:, **)
      hiera = Hiera.new(params[:environment_id])
      opts[:view][:node_data] = hiera.all_keys(params[:id])
      opts[:view][:node] = opts[:model]
    end

    def nodes!(opts, params:, current_user:, **)
      opts[:view][:nodes] = Node.all
    end
  end
end
