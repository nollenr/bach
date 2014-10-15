class ChangeFileExtesionNotNullOnLibraryFileSpec < ActiveRecord::Migration
  def change
    change_column_null :library_file_specs, :file_extension, false
  end
end
