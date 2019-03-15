class ApplicationController < ActionController::API
  # rescue_fromは後に書いたもののほうが優先される
  # railsガイドではrescue_fromにExceptionを指定するのは非推奨。
  # https://railsguides.jp/action_controller_overview.html#rescue-from

  #rescue_from Exception,                      with: :render_500
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(e)
    render_response(e, 404, 'Not found error')
  end

  private

    def render_response(e, status, message)
      logger.error "render_#{status}: #{message}"
      logger.error e.backtrace.join("\n")
      render status: status, json: { status: status, message: message }
    end

end
