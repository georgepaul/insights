class CreateBoarduserstats < ActiveRecord::Migration
  

  def change
    create_table :boarduserstats do |t|
      t.integer :board_id
      t.integer :user_id
      t.float :posts_per_day
      t.float :posts_per_hour
      t.float :avg_posts_per_hour
      t.float :avg_posts_per_day
      t.float :avg_unique_posts_per_day
      t.float :avg_unique_posts_per_hour
	  t.float :avg_unique_posts_per_minute
      t.timestamps
    end
  end


end
