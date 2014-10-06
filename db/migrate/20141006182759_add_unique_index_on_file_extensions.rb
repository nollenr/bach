class AddUniqueIndexOnFileExtensions < ActiveRecord::Migration
  def change
   add_index :file_extensions, :extension, :unique => true
  end
end
