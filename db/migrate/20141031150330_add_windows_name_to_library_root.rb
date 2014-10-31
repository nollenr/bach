class AddWindowsNameToLibraryRoot < ActiveRecord::Migration
  def change
    add_column :library_roots, :windows_name, :string
  end
end
