class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.integer :idofparent
      t.string :name
      t.boolean :isroot
      t.boolean :isleaf

      t.timestamps
    end
  end
end
