class ApplicationController < ActionController::Base
  rescue_from Hdm::Error, with: :show_error

  private

  def show_error(error)
    render(
      {
        html: cell(
          Reativo::Cell::Component,
          error,
          {
            layout: Theme::Cell::Layout,
            context: _run_options({ flash: flash, controller: self, component: "errors/Show", props: {error: error} })
          }
        ),
        status: 500
      }
    )
  end
end
