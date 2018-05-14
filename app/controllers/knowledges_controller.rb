class KnowledgesController < ApplicationController
  before_action :set_knowledge, only: [:show, :edit, :update, :destroy]

  # GET /knowledges
  # GET /knowledges.json
  def index
    @knowledges = Knowledge.all
  end
  
  # GET /knowledges/1
  # GET /knowledges/1.json
  def show
   
  end

  # GET /knowledges/new
  def new
     @courses =  Course.all
  end
  # GET /knowledges/1/edit
  def edit
    @courses =  Course.all
    @keywords = Keyword.all
  end

  # POST /knowledges
  # POST /knowledges.json
  def create
    @knowledge = Knowledge.new(knowledge_params)

    respond_to do |format|
      if @knowledge.save
        flash[:notice] = "已发布"
        format.html { redirect_to @knowledge, notice: 'Knowledge was successfully created.' }
        format.json { render :show, status: :created, location: @knowledge }
        redirect_to course_pages_question_path
      else
        format.html { render :new }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knowledges/1
  # PATCH/PUT /knowledges/1.json
  def update
    respond_to do |format|
      if @knowledge.update(knowledge_params)
        format.html { redirect_to @knowledge, notice: 'Knowledge was successfully updated.' }
        format.json { render :show, status: :ok, location: @knowledge }
      else
        format.html { render :edit }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledges/1
  # DELETE /knowledges/1.json
  def destroy
    @knowledge.destroy
    respond_to do |format|
      format.html { redirect_to knowledges_url, notice: 'Knowledge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reply_show
    # @replies = Reply.where(:topic => params[:topic_id]).all
  end
  
  def focus
    @knowledge = Knowledge.find(params[:tempknowledge])
    @user = User.find(params[:tempuser])
    focus_knowledge_relationships = @knowledge.focus_knowledge_associations.create
    focus_knowledge_relationships.user = @user
    focus_knowledge_relationships.save  
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  def unfocus
    @knowledge = Knowledge.find(params[:tempknowledge])
    @knowledge.followers.destroy(User.find(params[:tempuser]))
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  # 点赞/踩
  def good_add
    @knowledge = Knowledge.find(params[:tempknowledge])
    GoodAssociation.create(user_id: params[:tempuser], knowledge_id: params[:tempknowledge])
    Knowledge.update(@knowledge,:good => @knowledge.good+1)
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  
  def bad_add
    @knowledge = Knowledge.find(params[:tempknowledge])
    BadAssociation.create(user_id: params[:tempuser], knowledge_id: params[:tempknowledge])
    Knowledge.update(@knowledge,:bad => @knowledge.bad+1)
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  
  def good_sub
    @knowledge = Knowledge.find(params[:tempknowledge])
    @knowledge.like_users.destroy(User.find(params[:tempuser]))
    Knowledge.update(@knowledge,:good => @knowledge.good-1)
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  
  def bad_sub
    @knowledge = Knowledge.find(params[:tempknowledge])
    @knowledge.unlike_users.destroy(User.find(params[:tempuser]))
    Knowledge.update(@knowledge,:bad => @knowledge.bad-1)
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  
  def good_add_bad_sub
    @knowledge = Knowledge.find(params[:tempknowledge])
    GoodAssociation.create(user_id: params[:tempuser], knowledge_id: params[:tempknowledge])
    Knowledge.update(@knowledge,:good => @knowledge.good+1)
    @knowledge.unlike_users.destroy(User.find(params[:tempuser]))
    Knowledge.update(@knowledge,:bad => @knowledge.bad-1)
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  
  def good_sub_bad_add
    @knowledge = Knowledge.find(params[:tempknowledge])
    @knowledge.like_users.destroy(User.find(params[:tempuser]))
    Knowledge.update(@knowledge,:good => @knowledge.good-1)
    BadAssociation.create(user_id: params[:tempuser], knowledge_id: params[:tempknowledge])
    Knowledge.update(@knowledge,:bad => @knowledge.bad+1)
    respond_to do |format|
        format.js {}
        format.json { render json: @knowledge  , status: :success, location: @knowledge }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge
      @knowledge = Knowledge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledge_params
      params.require(:knowledge).permit(:author, :type, :time, :good, :bad)
    end

end
