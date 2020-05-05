class CreateQVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :q_votes do |t|
      t.integer :vote_id
      t.integer :type
      t.string :voted_by
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
