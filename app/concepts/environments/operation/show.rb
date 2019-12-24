module Environments::Operation
  class Show < Trailblazer::Operation
    step ->(options, params) { options["representer.render.class"] = Environments::Representer::Create }
    step :model!
    step :environments!
    step :nodes!

    def model!(opts, params:, current_user:, **)
      opts[:model] = Environment.new(params[:id])
    end

    def environments!(opts, params:, current_user:, **)
      opts[:view] = {}
      opts[:view][:environments] = Environment.all
    end

    def nodes!(opts, params:, current_user:, **)
      opts[:view][:nodes] = Node.all
    end
  end
end
