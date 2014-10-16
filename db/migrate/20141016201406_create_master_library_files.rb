class CreateMasterLibraryFiles < ActiveRecord::Migration
  def change
    create_table :master_library_files do |t|
      t.integer :idoflibraryrecord
      t.integer :idoflibaryfilespecrecord
      t.integer :filesizeinmb
      t.string  :artist
      t.string  :album
      t.decimal :length
      t.string  :comment
      t.string  :genre
      t.string  :title
      t.integer :track
      t.string  :year
      t.integer :bitrate
      t.integer :channels
      t.integer :sample_rate
      t.string  :file_extension
      t.integer :library_priority
      t.string  :original_directory_location
      t.timestamps
    end
  end
end
