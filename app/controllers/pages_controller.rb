class PagesController < ApplicationController

	layout 'admin'

  before_action :confirm_logged_in
  before_action :find_subject

  def index
    if @subject
      @pages = @subject.pages
    end
  end

  def show
		@page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => 'Default'})
		@subjects = Subject.order('position ASC')
		@page_count = Page.count + 1
  end

  def create
		if Page.create page_params
			flash[:notice] = 'Page added successfully'
			redirect_to(:action => :index, :subject_id => @subject.id)
		else
			render :new
		end
  end

  def edit
		@page = Page.find params[:id]
		@subjects = Subject.order('position ASC')
		@page_count = Page.count
	end

  def update
		@page = Page.find params[:id]
	  if @page.update_attributes page_params
		  flash[:notice] = 'Page updated successfully'
      redirect_to(:action => :index, :subject_id => @subject.id)
	  else
		  render(:edit, :subject_id => @subject.id)
	  end
  end

  def delete
	  @page = Page.find params[:id]
  end

  def destroy
	  @page = Page.find params[:id]
	  if @page.destroy
      flash[:notice] = 'Page deleted successfully'
      redirect_to(:action => :index, :subject_id => @subject.id)
    else
      @pages = @subject.pages.sorted
      render(:action => :index)
    end
  end

  private
    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end

    def page_params
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
    end
end
