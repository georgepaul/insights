class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
     	t.column :word_id, :integer
    	t.column :word_id, :string
    	t.column :user_id, :integer
      t.timestamps
    end
  end
end
