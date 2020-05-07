class Clap < ApplicationRecord
  belongs_to :article


  def Clap::check_if_present(user_id,q_id)
    query = {:claps_by => user_id , :article_id => q_id}
    @rec = Clap.where(query)
    if @rec.length > 0
        return @rec
    end
    return nil
  end

  def Clap::total_claps(a_id)
    query = {:article_id => a_id}
    @rec = Clap.where(query)

    return @rec.length
  end


end
