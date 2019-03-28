class CreateRents < ActiveRecord::Migration[5.1]
  def change
    create_table :rents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :rented_from, null: false
      t.date :rented_to, null: false
      t.date :returned_at

      t.timestamps
    end
  end
end
