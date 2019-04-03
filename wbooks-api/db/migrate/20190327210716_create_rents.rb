class CreateRents < ActiveRecord::Migration[5.1]
  def change
    create_table :rents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :borrowed_at, null: false
      t.date :returned_at, null: false

      t.timestamps
    end
  end
end
