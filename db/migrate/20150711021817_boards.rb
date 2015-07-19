class Boards < ActiveRecord::Migration
  def change

  	 create_table :boards do |t|
  	 	t.text, :name 
  	 	t.text, :board_link
  	 	t.integer, :posts
  	 	t.integer, :followers
  	 	t.text, :latest_post 
  	 	t.integer, :board_category_id
  	 	t.datetime, :last_post
	    t.timestamps
    end

  end
end
