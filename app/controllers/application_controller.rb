class ApplicationController < ActionController::API

  private

  def api_success hash = {}, warnings = []
    render json: hash.merge(success: true, warnings: warnings), status: 200
  end

  def api_error resource, status: 422
    msg = 
      if resource.respond_to?(:errors)
        resource.errors.try(:full_messages).presence || resource.errors
      else
        resource
      end

    render json: { msg: msg, success: false}, status: status
  end

end
