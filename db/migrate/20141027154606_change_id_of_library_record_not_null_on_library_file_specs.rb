class ChangeIdOfLibraryRecordNotNullOnLibraryFileSpecs < ActiveRecord::Migration
  def change
    change_column :library_file_specs, :idoflibraryrecord, :integer, null: false
  end
end
