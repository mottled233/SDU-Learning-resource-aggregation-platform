class StaticPagesController < ApplicationController
  def home
    @departments = Department.all
    @rank_blog = Blog.where("strftime('%s','now')-strftime('%s',created_at)<=15*24*60*60").order('"good"-"bad"').reverse_order.limit(8)
    @rank_blog = @rank_blog.where("check_state=?",1)
    @rank_res = Resource.where("strftime('%s','now')-strftime('%s',created_at)<=15*24*60*60").order('"good"-"bad"').reverse_order.limit(8)
    @rank_res = @rank_res.where("check_state=?",1)
    @user_new = User.order('created_at').reverse_order.limit(8)
    @user_active = []
    @user_blog = Blog.group(:user_id).count
    @user_ques = Question.group(:user_id).count
    @user_res = Resource.group(:user_id).count
    @user_all={}
    for i in 1..User.count
      unless (@user_blog.include?(i))
        @user_blog[i]=0
      end
      unless (@user_ques.include?(i))
        @user_ques[i]=0
      end
      unless (@user_res.include?(i))
        @user_res[i]=0
      end
      @user_all[i]=@user_blog[i]+@user_ques[i]+@user_res[i]
    end
    @user_all=@user_all.sort{|a,b|b[1]<=>a[1]}
    for i in 0..3
      @user_active[i]=User.find(@user_all[i][0])
    end
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
      
      @reply=[]
      
      if (current_user!=nil and current_user.interest!="")
        @user_course=current_user.interest.split(";");
      else
        @user_course=nil
      end
      case params["specify"]
        when 11 then
          @results = Blog.where(check_state: 1).order('created_at').reverse_order.limit(8)
        when 12 then
          @results = Resource.where(check_state: 1).order('created_at').reverse_order.limit(8)
        when 21 then
          @results = Blog.where(check_state: 1).order('"score" - "score_yesterday"').reverse_order.limit(8)
        when 22 then 
          @results = Resource.where(check_state: 1).order('"score" - "score_yesterday"').reverse_order.limit(8)
        when 31 then
          @results = []
          if (@user_course!=nil)
            
            
            @user_course.each do |c|
              if (Course.find_by(name: c).knowledges.where(tyle:"Blog").length==0)
                @user_course[	array.index(c)]=""
              end
              a.delete("")
            end
            @alloc=Array.new(@user_course.length,0)
            @limit=Array.new(@user_course.length)
            @limit[0]=@user_course.length
            (1..@user_course.length-1).each do |i|
              @limit[i]=@limit[i-1]+(@user_course.length-i)
            end
            (1..8).each do |i|
              rnd=rand(1..@user_course.length*(@user_course.length-1))
              (0..@user_course.length-1).each do |j|
                if (rnd>@limit[j])
                  @alloc[j]+=1
                  break
                end
              end
            end
            t=0
            @user_course.each do |c|
              @results = @results + Course.find(c["id"]).knowledges.where(type: "Blog").order('"score" - "score_yesterday"').reverse_order.limit(alloc[t])
              t+=1
            end
            @results.sort!{ |x,y| y["score"]-y["score_yesterday"]<=>x["score"]-x["score_yesterday"]}
            @results=@results[0,8]
          else
            @results = Blog.where(check_state: 1).order('"score" - "score_yesterday"').reverse_order.limit(8)
          end
        when 32 then
          
          if (@user_course!=nil)
            @results = []
            @user_course.each do |c|
              @results = @results + Course.find(c["id"]).knowledges.where(type: "Resource").order('"score" - "score_yesterday"').reverse_order.limit(8)
            end
            @results.sort!{ |x,y| y["score"]-y["score_yesterday"]<=>x["score"]-x["score_yesterday"]}
            @results=@results[0,8]
          else
            @results = Resource.where(check_state: 1).order('"score" - "score_yesterday"').reverse_order.limit(8)
          end
      end
      i=0
      @results.each do |res|
        res["content"]=short_digest(res.content_without_html,20)
        @reply[i] = res.getAllReplies.size
        i+=1
      end
      format.json {render json:{'status'=>'200','message'=>'OK','data'=>@results,'reply'=>@reply}}
    end
  end
end
