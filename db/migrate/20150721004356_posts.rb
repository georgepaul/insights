class Posts < ActiveRecord::Migration
   def change
    create_table :posts do |t|
      
      t.integer :board_id
      t.integer :user_id
      t.string :post_link
      t.text :post_date
      t.string :post_title
      t.integer :message_id, :limit => 8
      t.integer :post_number
      t.text :post_body, :limit => 64.kilobytes + 1
	    t.timestamps
      
    end
  end
end
