class AddIsMasterToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :ismaster, :boolean, {default: false, null: false}
  end
end
