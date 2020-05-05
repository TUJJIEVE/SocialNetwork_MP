class CreateAVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :a_votes do |t|
      t.integer :vote_id
      t.integer :vote_type
      t.string :voted_by
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
