class QVote < ApplicationRecord
  belongs_to :question


  def QVote::check_if_present(user_name,q_id)
    query = {:voted_by => user_name , :question_id => q_id}
    @rec = QVote.where(query)
    if @rec.length > 0
        return @rec
    end
    return nil
  end

  def QVote::total_up_votes(q_id)
    query = {:question_id => q_id, :vote_type => 0}
    @rec = QVote.where(query)

    return @rec.length
  end

  def QVote::total_down_votes(q_id)
    query = {:question_id => q_id, :vote_type => 1}
    @rec = QVote.where(query)
    return @rec.length
  end
end
