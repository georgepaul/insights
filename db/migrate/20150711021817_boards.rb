class Boards < ActiveRecord::Migration
  def change

  	 create_table :boards do |t|
      t.column :name, :string
      t.column :board_url, :string
      t.column :board_total_posts, :integer
      t.column :board_latest_post, :integer
	    t.timestamps
    end

  end
end
