class ScoreCalculateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Knowledge.all.each do |k|
      visit = (k.visit_count>0 ? k.visit_count : 1)
      focus = k.followers.length
      comments = k.getAllReplies.length
      good_per = k.good.to_f/(k.good+k.bad)
      
      visit_cor = 1+good_per*0.5
      focus_cor = 15+20*[focus.to_f/visit,0.25].min
      comment_cor = 10*(visit+15*focus)/(visit+15*focus+comments)
      
      score = visit*visit_cor+focus*focus_cor+comments*comment_cor
      
      k.score_yesterday = (k.score==nil ? 0 : k.score)
      k.score = score
      k.save
    end
    ScoreCalculateJob.set(wait_until:Date.tomorrow.midnight).perform_later
  end
end
