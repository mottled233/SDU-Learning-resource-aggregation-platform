class ScoreCalculateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Knowledge.all.each do |k|
      visit = k.visit_count
      focus = k.followers.length
      comments = k.getAllReplies.length
      good_per = k.good+k.bad>0?(k.good.to_f/(k.good+k.bad)) : 0
      
      visit_cor = 1+good_per*0.5
      focus_cor = visit>0?(15+20*[focus.to_f/visit,0.25].min) : 0
      comment_cor = visit>0?(10*(visit+15*focus)/(visit+15*focus+comments)) : 0
      
      score = visit*visit_cor+focus*focus_cor+comments*comment_cor
      
      k.score_yesterday = (k.score==nil ? 0 : k.score)
      k.score = score
      k.save
    end
    ScoreCalculateJob.set(wait_until:Date.tomorrow.midnight).perform_later
  end
end
