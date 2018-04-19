class CoursePagesController < ApplicationController
  def home
  end

  def question
    @question = Knowledge.get_all_entry('Question')
  end

  def blog
  end

  def resource
  end

  def add_evalute
    # if  [params:ev_type].equal?'good'
    #   Knowledge..find([params:q_id]).good = Knowledge.find([params:q_id]).good +1;
    # else if [params:ev_type].equal?'bad'
    #        Knowledge..find([params:q_id]).bad = Knowledge.find([params:q_id]).bad +1;
    #      end
    # end
  end

  def question_new

  end
end
