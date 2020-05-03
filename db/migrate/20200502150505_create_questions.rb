class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question_id
      t.string :title
      t.text :text
      t.integer :user_id
      t.binary :is_answered
      t.datetime :posted_on

      t.timestamps
    end
  end
end
