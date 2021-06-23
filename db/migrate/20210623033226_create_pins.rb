class CreatePins < ActiveRecord::Migration[6.1]
  def change
    create_table :pins do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title
      t.string :about

      t.timestamps
    end
  end
end
