class ProjectsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
    end

    def edit
    end

    def show
        
    end

    def create
         @project = Project.new(project_params)

        respond_to do |format|
            if @project.save
                format.html { redirect_to @project, notice: 'Project was successfully created.' }
                format.json { render action: 'show', status: :created, location: @project }
            else
                format.html { render action: 'new' }
                format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end
    end

    private 

    def set_product
      @project = Project.find(params[:id])
    end

    def project_params
    
        params.require(:project).permit(:name, :desc, :ext_link, :budget)
    
    end

end
