class CreateLibraryRoots < ActiveRecord::Migration
  def change
    create_table :library_roots do |t|
      t.string :name, null: false
      t.integer :priority, null: false

      t.timestamps
    end
  end
end
