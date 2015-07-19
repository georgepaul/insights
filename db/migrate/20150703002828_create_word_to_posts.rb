class CreateWordToPosts < ActiveRecord::Migration
  def change
    create_table :word_to_posts do |t|
		t.post_id :integer
		t.word_id :integer
		t.user_id :integer 
		t.source_type :integer
		t.timestamps
    end
  end
end
