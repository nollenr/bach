class AddIsMasterToLibraryFileSpecs < ActiveRecord::Migration
  def change
    add_column :library_file_specs, :ismaster, :boolean, default: false
  end
end
