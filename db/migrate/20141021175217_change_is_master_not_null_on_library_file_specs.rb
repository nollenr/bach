class ChangeIsMasterNotNullOnLibraryFileSpecs < ActiveRecord::Migration
  def change
    change_column :library_file_specs, :ismaster, :boolean, null: false
  end
end
