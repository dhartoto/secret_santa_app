class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :full_name
      t.string :partner_full_name
      t.integer :year_id
    end
    add_index :participants, :year_id
  end
end
