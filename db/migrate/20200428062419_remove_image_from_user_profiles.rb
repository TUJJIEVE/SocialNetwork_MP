class RemoveImageFromUserProfiles < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_profiles, :image, :string
  end
end
