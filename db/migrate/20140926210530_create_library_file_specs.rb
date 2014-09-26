class CreateLibraryFileSpecs < ActiveRecord::Migration
  def change
    create_table :library_file_specs do |t|
      t.integer :idoflibraryrecord
      t.integer :filesizeinmb
      t.string :artist
      t.string :album
      t.decimal :length

      t.timestamps
    end
  end
end
