class Api::V1::ContentsController < ApiController
    before_action :authorize_request, except: [:index, :show]
    before_action :set_owner_project,  only: [:create, :update, :destroy]
    before_action :set_project,  only: [:index, :show]
    before_action :set_content,  only: [:update, :destroy]

    def index
        @contents = @project.contents.includes(project: :user).all
    end   
    
    def show 
        @content = @project.contents.find_by_id(params[:id])
        if @content.nil?
            render json: {message: "Error: Project Not Foound"}, status: 400
            return
        end      
    end 

    def update
		if @content.update(content_params)
            render 'show'
        else
            render json: {message: @content.errors}, status: :unprocessable_entity
        end
    end
    
    def create
        @content = @project.contents.new(content_params)
        if @content.save
            render 'show'
        else
            render json: {message: @content.errors}, status: :unprocessable_entity
        end
    end    

    def destroy
		if @content.destroy
			render json: { message: "Successfully Deleted" }, status: 200
		else
			render json: {message: @content.errors}, status: :unprocessable_entity
		end
	end

    private
    def set_owner_project
        @project = @user.projects.find_by_id(params[:project_id])
        if @project.nil?
          render json: {message: "Error: Unauthorized Access"}, status: :unauthorized
          return
        end
    end

    def set_project
        @project = Project.find_by_id(params[:project_id])
        if @project.nil?
          render json: {message: "Error: Project Not Found"}, status: 400
          return
        end
    end

    def set_content
        @content = @project.contents.find_by_id(params[:id])
        if @content.nil?
          render json: {message: "Error: Unauthorized Access"}, status: :unauthorized
          return
        end
    end

    def content_params
        params.permit(:id, :title, :body)
    end   
end
