module Editor::Operation
  class Index < Trailblazer::Operation
    step ->(options, params) { options["representer.render.class"] = Editor::Representer::Index }
    step ->(options, params) { options["representer.errors.class"] = Reativo::Representer::Errors }
    step :model!

    def model!(ctx, params:, current_user:, **)
      ctx[:model] = Environment.all
    end
  end
end
