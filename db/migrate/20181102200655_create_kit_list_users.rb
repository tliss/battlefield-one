class CreateKitListUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :kit_list_users do |t|
      t.integer :user_id
      t.integer :kit_list_id

      t.timestamps
    end
  end
end
