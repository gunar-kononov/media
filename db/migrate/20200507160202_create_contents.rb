class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.references :media, polymorphic: true
      t.references :content, foreign_key: true
      t.boolean :purchasable

      t.timestamps
    end
  end
end
