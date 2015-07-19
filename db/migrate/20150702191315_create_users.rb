class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.text :name
        t.text :profile_link
        t.integer :followed_by, :limit => 8
        t.integer :posts, :limit => 8
        t.integer :boards_moderated, :limit => 8
        t.datetime :alias_born
        t.integer :user_id, :limit => 8
    end
  end
end
