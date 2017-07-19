class CreateBananas < ActiveRecord::Migration[5.0]
  def change
    create_table :bananas do |t|
        t.integer :farm_banana_index, null: false, unique: true
        t.integer :farm_id, null: false
        t.string  :banana_name, null: false
        t.integer :value, null: false
        t.integer :length, null: false
        
        t.timestamps
    end
  end
end
