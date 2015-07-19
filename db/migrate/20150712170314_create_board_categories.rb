class CreateBoardCategories < ActiveRecord::Migration
  def change
    create_table :board_categories do |t|
    	t.string :name
    	t.string :link
		t.timestamps
    end
  end
end
