class CreateFertilizers < ActiveRecord::Migration[5.0]
  def change
    create_table :fertilizers do |t|
      t.integer :value

      t.timestamps
    end
  end
end
