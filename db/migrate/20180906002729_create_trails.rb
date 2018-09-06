class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.integer :length
      t.string :name
      t.integer :difficulty
      t.integer :start_alt
      t.integer :end_alt
      t.integer :state_id
    end
  end
end
