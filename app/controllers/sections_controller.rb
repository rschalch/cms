class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_page

  def index
    if @page
      @sections = @page.sections
    else
      @sections = Section.order('name')
    end
  end

  def show
    @section = Section.find params[:id]
  end

  def new
    @section = Section.new({:name => 'Default', :page_id => @page.id})
    @pages = Page.where("subject_id = '#{@subject.id}'")
    @section_count = Section.count + 1
  end

  def create
    if Section.create section_params
      flash[:notice] = 'Section created successfully'
      redirect_to(action: :index, :subject_id => @subject.id, :page_id => @page.id)
    else
      render :new
    end
  end

  def edit
    @section = Section.find params[:id]
    @section_count = Section.count
    @pages = Page.order('position ASC')
  end

  def update
    section = Section.find params[:id]
    @section_count = Section.count

    if section.update_attributes section_params
      flash[:notice] = 'Section updated successfully'
      redirect_to(action: :index, :page_id => @page.id)
    else
      render :edit
    end
  end

  def delete
    @section = Section.find params[:id]
  end

  def destroy
    section = Section.find params[:id]
    if section.destroy
      flash[:notice] = 'Section deleted successfully'
      redirect_to(action: :index, :subject_id => @subject.id, :page_id => @page.id)
    end
  end

  private
  def find_page
    if params[:page_id]
      @page = Page.find(params[:page_id])
      @subject = Subject.find(@page.subject_id)
    end
  end

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end