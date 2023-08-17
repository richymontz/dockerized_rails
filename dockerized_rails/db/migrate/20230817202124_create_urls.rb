class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url
      t.string :title

      t.timestamps
    end
  end
end
