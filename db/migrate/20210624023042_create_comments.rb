class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pin, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
