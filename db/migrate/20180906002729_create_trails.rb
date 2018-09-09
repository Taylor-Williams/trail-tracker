class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.float :length
      t.string :name
      t.string :slug
      t.integer :difficulty
      t.float :start_alt
      t.float :end_alt
      t.integer :state_id
    end
  end
end
