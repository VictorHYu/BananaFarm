class AddWeatherLastUpdatedToFarm < ActiveRecord::Migration[5.1]
  def change
      add_column :farms, :weather_last_updated, :datetime, null: false, default: DateTime.new(2000, 1, 1, 1, 1, 1)
  end
end
