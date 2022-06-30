class Api::V1::ProjectsController < ApiController
  before_action :authorize_request
  before_action :set_project,  only: [:update]

  def update
		if @project.update(update_params)
      render 'show'
    else
      render json: {message: @project.errors}, status: :unprocessable_entity
    end
  end

  def create
    @project = @user.projects.new(project_params)
    if @project.save
      render 'show'
    else
      render json: {message: @project.errors}, status: :unprocessable_entity
    end
  end  
  
  private
  def set_project
    @project = @user.projects.find_by_id(params[:id])
    if @project.nil?
      render json: {message: "Error: Unauthorized Access"}, status: :unauthorized
      return
    end
  end

  def project_params
    params.permit(:title, :description, :location, :project_type, :thumbnail)
  end

  def update_params
    params.permit(:id, :title, :description, :location, :project_type)
  end
end
