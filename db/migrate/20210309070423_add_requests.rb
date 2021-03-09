class AddRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :ip
      t.text   :info
      t.references :url

      t.timestamps
    end
  end
end
