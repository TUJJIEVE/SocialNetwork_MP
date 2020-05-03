class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :answer_id
      t.datetime :posted_on
      t.references :question, null: false, foreign_key: true
      t.text :body
      t.string :posted_by

      t.timestamps
    end
  end
end
