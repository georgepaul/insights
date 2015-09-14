class Wordsaretickets < ActiveRecord::Migration
  def change
     add_column :words, :is_ticker, :integer, :default => 0
  end
end
