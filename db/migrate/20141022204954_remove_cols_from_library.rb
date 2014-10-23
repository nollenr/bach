class RemoveColsFromLibrary < ActiveRecord::Migration
  def change
    remove_column :libraries, :ismaster, :boolean
    remove_column :libraries, :newlibraryrec, :boolean
  end
end
