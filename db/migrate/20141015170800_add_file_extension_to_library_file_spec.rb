class AddFileExtensionToLibraryFileSpec < ActiveRecord::Migration
  def change
    add_column :library_file_specs, :file_extension, :string
  end
end
