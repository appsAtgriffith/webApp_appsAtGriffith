class ProjectsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:edit, :update, :destroy,  :create]
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

    def update
        respond_to do |format|
          if @project.update(project_params)
            format.html { redirect_to @project, notice: 'Project was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
            format.json { render json: @project.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        @project.destroy
            respond_to do |format|
            format.html { redirect_to projects_url }
            format.json { head :no_content }
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
