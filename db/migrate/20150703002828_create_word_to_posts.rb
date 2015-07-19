class CreateWordToPosts < ActiveRecord::Migration
  def change
    create_table :word_to_posts do |t|
		t.integer :post_id
		t.integer :word_id
		t.integer :user_id 
		t.integer :source_type
		t.timestamps
    end
  end
end
