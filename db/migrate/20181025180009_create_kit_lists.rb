class CreateKitLists < ActiveRecord::Migration[5.2]
  def change
    create_table :kit_lists do |t|
      t.string :origin_user

      t.timestamps
    end
  end
end
