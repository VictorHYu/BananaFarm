class AddWeatherToFarm < ActiveRecord::Migration[5.1]
  def change
      add_column :farms, :weather_temperature, :integer, null: false, default: '999'
      add_column :farms, :weather_main, :string, null: false, default: 'none'
      add_column :farms, :weather_icon, :string, null: false, default: '01d.png'
  end
end
