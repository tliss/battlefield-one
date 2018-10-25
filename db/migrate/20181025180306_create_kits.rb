class CreateKits < ActiveRecord::Migration[5.2]
  def change
    create_table :kits do |t|
      t.integer :number
      t.string :name
      t.references :kit_list, foreign_key: true

      t.timestamps
    end
  end
end
