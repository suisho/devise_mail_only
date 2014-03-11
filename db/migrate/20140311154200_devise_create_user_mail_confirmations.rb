class DeviseCreateUserMailConfirmations < ActiveRecord::Migration
  def change
    create_table(:user_mail_confirmations) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable



      t.timestamps

      t.integer :user_id
    end

    add_index :user_mail_confirmations, :email,                :unique => true
    add_index :user_mail_confirmations, :confirmation_token,   :unique => true
    # add_index :user_mail_confirmations, :unlock_token,         :unique => true
  end
end
