class ChangeWindowsNameOnLibraryRootToNotNull < ActiveRecord::Migration
  def change
    change_column :library_roots, :windows_name, :string, null: false
  end
end
