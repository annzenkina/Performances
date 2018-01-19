class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :theatre
      t.datetime :starts_on
      t.decimal :price
      t.string :link
      t.string :tags
      t.string :poster
      t.string :description

      t.timestamps
      # created_at updated_at
    end
  end
end
