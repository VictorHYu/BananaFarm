class CreateFarms < ActiveRecord::Migration[5.0]
  def change
    create_table :farms do |t|
      t.string :title

      t.timestamps
    end
  end
end
