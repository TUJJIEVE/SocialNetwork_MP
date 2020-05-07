class CreateClaps < ActiveRecord::Migration[6.0]
  def change
    create_table :claps do |t|
      t.integer :claps_by
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
