class AddLibraryPriorityToLibraryFileSpec < ActiveRecord::Migration
  def change
    add_column :library_file_specs, :library_priority, :integer, null: false
  end
end
