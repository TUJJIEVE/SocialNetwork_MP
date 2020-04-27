class CreateCollegues < ActiveRecord::Migration[6.0]
  def change
    create_table :collegues do |t|
      t.integer :id1
      t.integer :id2
      t.boolean :blocked

      t.timestamps
    end
  end
end
