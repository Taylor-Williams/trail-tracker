class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.real :length
      t.string :name
      t.string :slug
      t.integer :difficulty
      t.real :start_alt
      t.real :end_alt
      t.integer :state_id
    end
  end
end
