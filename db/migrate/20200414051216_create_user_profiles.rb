class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.string :uname
      t.string :full_name
      t.time :dob
      t.string :college_id
      t.string :country
      t.binary :image
      t.integer :points
      t.time :created_on
      t.time :last_active

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :user_profiles, [:user_id, :uname]
  end
end
