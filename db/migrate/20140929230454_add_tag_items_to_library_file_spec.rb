class AddTagItemsToLibraryFileSpec < ActiveRecord::Migration
  def change
    add_column :library_file_specs, :comment, :string
    add_column :library_file_specs, :genre, :string
    add_column :library_file_specs, :title, :string
    add_column :library_file_specs, :track, :string
    add_column :library_file_specs, :year, :string
  end
end
