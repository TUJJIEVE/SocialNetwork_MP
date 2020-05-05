class ChangeDobToBeDatetimeInUserprofiles < ActiveRecord::Migration[6.0]
  def change
    change_column :user_profiles, :dob, :timestamp
  end
end
