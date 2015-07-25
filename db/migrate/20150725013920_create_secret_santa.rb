class CreateSecretSanta < ActiveRecord::Migration
  def change
    create_table :secret_santa do |t|
      t.integer :participant_id
      t.integer :giver_id
      t.integer :year_id
    end
    add_index :secret_santa, :participant_id
    add_index :secret_santa, :year_id
  end
end
