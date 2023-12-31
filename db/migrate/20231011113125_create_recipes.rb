class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :preparation_time
      t.integer :cooking_time
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
