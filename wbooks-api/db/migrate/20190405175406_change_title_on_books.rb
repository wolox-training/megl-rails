class ChangeTitleOnBooks < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        Book.where('length(title) > 25').each do |book|
          book.title = "#{book.title[0..21]}..."
          book.save!
        end

        change_column :books, :title, :string, limit: 25
      end

      dir.down do
        change_column :books, :title, :string, limit: nil
      end
    end
  end
end
