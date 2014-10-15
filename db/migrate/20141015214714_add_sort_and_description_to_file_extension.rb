class AddSortAndDescriptionToFileExtension < ActiveRecord::Migration
  def change
    add_column :file_extensions, :sort_order, :integer
    add_column :file_extensions, :description, :string
  end
end
