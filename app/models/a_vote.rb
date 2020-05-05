class AVote < ApplicationRecord
  belongs_to :answer

  def AVote::check_if_present(user_name,a_id)
    query = {:voted_by => user_name , :answer_id => a_id}
    @rec = AVote.where(query)
    if @rec.length > 0
        return @rec
    end
    return nil
  end

  def AVote::total_up_votes(a_id)
    query = {:answer_id => a_id, :vote_type => 0}
    @rec = AVote.where(query)

    return @rec.length
  end

  def AVote::total_down_votes(a_id)
    query = {:answer_id => a_id, :vote_type => 1}
    @rec = AVote.where(query)
    return @rec.length
  end
end
