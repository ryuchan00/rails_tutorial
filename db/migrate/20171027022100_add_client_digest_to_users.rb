class AddClientDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :client_id_token, :string
    add_column :users, :client_secret_token, :string
    add_column :users, :client_secret_digest, :string
  end
end
