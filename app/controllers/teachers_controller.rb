class TeachersController < ApplicationController

    

  def index
    @teachers = User.where("user_role=?",:teacher)
  end
  
  def show
    @teacher = User.find(params[:id])
    @courses = @teacher.selected_courses
  end
  
  def edit
  end
    
end