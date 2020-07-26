class CreateSeriesBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :series_books do |t|
      t.string :name

      t.timestamps
    end
  end
end
