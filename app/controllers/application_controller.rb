class ApplicationController < ActionController::API
  # rescue_fromは後に書いたもののほうが優先される
  # railsガイドではrescue_fromにExceptionを指定するのは非推奨。
  # https://railsguides.jp/action_controller_overview.html#rescue-from

  #rescue_from Exception,                      with: :render_500
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(e)
    status, message  = 404, 'Not found error'
    logger_error(e, status, message)
    render_response(status, message)
  end

  def render_200(message, data = {})
    render_response(status, message, data)
  end

  private

    def logger_error(e, status, message)
      logger.error "render_#{status}: #{message}"
      logger.error e.backtrace.join("\n")
    end

    def render_response(status, message, data)
      render status: status, json: { status: status, message: message, data: data }
    end

end
