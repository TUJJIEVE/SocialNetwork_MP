class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|

      t.integer :sender_id  , index: true  # request sender
      t.integer :accepter_id , index: true # request accepter
      
      t.integer :status , default: 0 
      
      t.timestamps
    end
  end
end
