class Api::V1::ProjectsController < ApiController
    before_action :authorize_request

    def create
        @project = @user.projects.new(project_params)
        if @project.save
          render 'show'
        else
          render json: {message: @project.errors}, status: :unprocessable_entity
        end
    end  
    
    private
    def project_params
        params.permit(:title, :description, :location, :project_type, :thumbnail)
    end
end
