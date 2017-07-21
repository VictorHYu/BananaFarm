class AddStatsToBananas < ActiveRecord::Migration[5.1]
  def change
      add_column :bananas, :tier, :integer, null: false
      add_column :bananas, :stat_type, :string, null: false
      add_column :bananas, :growth_stat, :integer, null: false
      add_column :bananas, :time_stat, :integer, null: false
      add_column :bananas, :value_stat, :integer, null: false
      add_column :bananas, :weather_type, :string, null: false
      add_column :bananas, :is_special, :boolean, null: false
  end
end
