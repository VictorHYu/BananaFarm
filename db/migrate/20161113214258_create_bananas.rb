class CreateBananas < ActiveRecord::Migration[5.0]
  def change
  	drop_table :bananas
    create_table :bananas do |t|
      t.integer :length
      t.string :flavour

      t.timestamps
    end
  end
end
