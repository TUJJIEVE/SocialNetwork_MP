class RenameQVoteTypeToVoteType < ActiveRecord::Migration[6.0]
  def change
      rename_column :q_votes, :type , :vote_type
  end
end
