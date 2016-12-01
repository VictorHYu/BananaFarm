class AddFarmIdToBananas < ActiveRecord::Migration[5.0]
  def change
    add_column :bananas, :farm_id, :integer
  end
end
