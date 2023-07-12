class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :request_id
      t.string :user_agent
      t.string :ip_address
      t.references :recordable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
