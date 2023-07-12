class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
