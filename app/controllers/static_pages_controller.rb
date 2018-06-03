class StaticPagesController < ApplicationController
  def home
    @departments = Department.all
  end
  
  def test_page
  end
  
  def show_speciality
    respond_to do |format|
      if params["specify"]==1
        selected_department = params["department_id"];
        @speciality = Speciality.select("id,name").where("department_id=?",selected_department);
      else
        selected_department = params["department_id"];
        @speciality = Speciality.find_by(id:selected_department).courses.select('course_name','id');
      end
      format.json {render json:{'status'=>'200','message'=>'OK','data'=>@speciality,'count'=>@speciality.size,'specify'=>params["specify"]}};
    end
  end
  
  def unfinished
  end
    
  def home_change
    respond_to do |format|
      @subj=[]
      case params["specify"]
        when 11 then
          @results = Blog.order('created_at').reverse_order.limit(8)
        when 12 then
          @results = Resource.order('created_at').reverse_order.limit(8)
        when 21 then
          @results = Blog.order('"good" - "bad"').reverse_order.limit(8)
        when 22 then 
          @results = Resource.order('"good" - "bad"').reverse_order.limit(8)
        when 31 then
          @results = Blog.joins(:creator).where('users.speciality=:speciality',{speciality:"空"}).order('good').reverse_order.limit(8)
        when 32 then
          @results = Resource.joins(:creator).where('users.speciality=:speciality',{speciality:"空"}).order('good').reverse_order.limit(8)
      end
      format.json {render json:{'status'=>'200','message'=>'OK','data'=>@results}}
    end
  end
end
