class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :genre, null: false
      t.string :author, null: false
      t.string :title, null: false
      t.references :image, foreign_key: true, null: false
      t.string :publisher, null: false
      t.string :year, null: false

      t.timestamps
    end
  end
end
