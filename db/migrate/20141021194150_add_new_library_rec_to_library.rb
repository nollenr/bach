class AddNewLibraryRecToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :newlibraryrec, :boolean, default: true
  end
end
