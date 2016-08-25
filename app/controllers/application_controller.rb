class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception, with: :log_exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def log_exception(e)
      logger.error "#{e.message} - #{e.backtrace.inspect}"
      render_error([{title: e.class.name.underscore, message: e.message}],
                     :internal_server_error)
    end

    def render_error(errors, status)
      render json: { errors:errors }, status: status
    end

    def build_model_errors(obj)
      obj.errors.collect do |title, message|
        {title: title, message: message}
      end
    end
end
