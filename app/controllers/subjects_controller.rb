class SubjectsController < ApplicationController

	layout 'admin'

  before_action :confirm_logged_in

	def index
		@subjects = Subject.all
	end

	def show
		@subject = Subject.find params[:id]
	end

	def new
		@subject = Subject.new({name: 'Default'})
		@subject_count = Subject.count + 1
	end

	def create
		@subject = Subject.new(subject_params)
		if @subject.save
			flash[:notice] = 'Subject created successfully'
			redirect_to :action => :index
		else
			render 'new'
		end
	end

	def edit
		@subject = Subject.find params[:id]
		@subject_count = Subject.count
	end

	def delete
		@subject = Subject.find params[:id]
	end

	def update
		@subject = Subject.find(params[:id])
    	@subject_count = Subject.count
    
		if @subject.update_attributes subject_params
			flash[:notice] = 'Subject updated successfully'
			redirect_to :action => :show, :id => params[:id]
   		else
			render 'edit'
		end
	end

	def destroy
		@subject = Subject.find(params[:id])
	    if @subject.destroy
	      flash[:notice] = "Subject '#{@subject.name}' deleted successfully"
	      redirect_to(:action => :index)
	    else
	      @subjects = Subject.all
	      render(:action => :index )
	    end
	end

  def pages
  end

  private
	def subject_params
		params.require(:subject).permit(:name, :position, :visible)
	end
end
