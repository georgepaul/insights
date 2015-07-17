class CreateLogics < ActiveRecord::Migration
  def change
    create_table :logics do |t|

      t.timestamps
    end
  end
end
