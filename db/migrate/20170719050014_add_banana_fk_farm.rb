class AddBananaFkFarm < ActiveRecord::Migration[5.1]
  def change
      add_foreign_key :bananas, :farms, column: :farm_id
  end
end
