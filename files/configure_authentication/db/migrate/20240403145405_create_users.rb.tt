class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :auth_token
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false
      t.string :user_name

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
