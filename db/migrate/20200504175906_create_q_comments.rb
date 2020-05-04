class CreateQComments < ActiveRecord::Migration[6.0]
  def change
    create_table :q_comments do |t|
      t.string :commenter
      t.text :body
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
