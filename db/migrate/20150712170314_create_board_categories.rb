class CreateBoardCategories < ActiveRecord::Migration
  def change
    create_table :board_categories do |t|
    	t.column :name, :string
    	t.column :link, :string

      t.timestamps
    end
  end
end
