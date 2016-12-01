class AddValueToBananas < ActiveRecord::Migration[5.0]
  def change
    add_column :bananas, :value, :integer
  end
end
