class CreatePriceByDayRecords < ActiveRecord::Migration
  def change
    create_table :price_by_day_records do |t|

      t.timestamps
    end
  end
end
