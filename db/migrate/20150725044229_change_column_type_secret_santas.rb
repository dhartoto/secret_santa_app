class ChangeColumnTypeSecretSantas < ActiveRecord::Migration
  def change
    remove_column :secret_santa, :giver_id
    add_column :secret_santa, :full_name, :string
  end
end
