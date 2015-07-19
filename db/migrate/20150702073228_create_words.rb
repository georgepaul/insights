class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
    	t.text :name
      t.timestamps
    end
  end
end
