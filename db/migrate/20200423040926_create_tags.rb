class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name , unique: true
      t.float :popularity , default: 0.0
      t.references :user, index:false , foreign_key: true

      t.timestamps
    end
    add_index :tags, [:name]
  end
end
