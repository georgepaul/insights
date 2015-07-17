class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.column :name, :string
    	t.column :profile_link, :string
    	t.column :followed_by, :integer
    	t.column :posts, :integer
    	t.column :boards_moderated, :integer 
    	t.column :alias_born, :timestamp
        t.column :user_id, :integer
    end
  end
end
