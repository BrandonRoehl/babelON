class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound do |message|
        logger.error message
        respond_to do |format|
            format.json do
                render json: {error: "404 record not found"}, status: :not_found
            end
            format.html do
                raise ActionController::RoutingError.new('Not Found')
            end
        end
    end

    # No layout for ajax
    layout proc{|c| c.request.xhr? ? false : "application"}

    def splash
        render "splash/index"
    end

end
