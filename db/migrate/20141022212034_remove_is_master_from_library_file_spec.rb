class RemoveIsMasterFromLibraryFileSpec < ActiveRecord::Migration
  def change
    remove_column :library_file_specs, :ismaster, :boolean
  end
end
