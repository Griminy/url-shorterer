class AddUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :short
      t.string :long
      t.integer :request_count, default: 0

      t.timestamps
    end
  end
end
