class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.references :account, null: false, foreign_key: true
      t.string :timezone

      t.timestamps
    end
  end
end
