class AddNotNullToLibrary < ActiveRecord::Migration
  def change
    change_column_null :libraries, :name, false
    change_column_null :libraries, :isroot, false
    change_column_null :libraries, :isleaf, false
    change_column_default :libraries, :isroot, false
    change_column_default :libraries, :isleaf, false
  end
end
