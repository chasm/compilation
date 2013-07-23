class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name_first
      t.string :name_last
      t.date :born_on
      t.string :spottify_key
      t.string :pandora_key
      t.string :last_fm_key
      t.string :email
      t.boolean :is_superuser, default: false
      t.string :salt
      t.string :fish
      t.string :code
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
