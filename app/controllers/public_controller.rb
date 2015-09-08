class PublicController < ApplicationController

  layout 'public'

  before_action :set_nav

  def index    
  end

  def show
    @page = Page.where(:permalink => params[:permalink], visible: true).first
    if @page.nil?
      redirect_to :action => :index
    end
  end

  private
  def set_nav
    @subjects = Subject.visible.sorted
  end
end
