class CreatePageCustoms < ActiveRecord::Migration
  def change
    create_table :page_customs do |t|
      t.string :url
      t.string :redirect
      t.string :title
      t.string :metadescription
      t.string :metakeywords
      t.text :content

      t.timestamps
    end
  end
end
