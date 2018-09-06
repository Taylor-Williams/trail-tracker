class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :slug
      t.string :password_digest
      t.string :email
      t.string :bio
    end
  end
end
