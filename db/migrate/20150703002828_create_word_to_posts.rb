class CreateWordToPosts < ActiveRecord::Migration
  def change
    create_table :word_to_posts do |t|
		t.column :post_id, :integer
    	t.column :word_id, :string
    	t.column :user_id, :integer
		t.timestamps
    end
  end
end
