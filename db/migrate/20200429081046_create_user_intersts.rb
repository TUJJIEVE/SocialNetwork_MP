class CreateUserIntersts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_intersts do |t|

      t.references :user, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps
    end
  end
end
