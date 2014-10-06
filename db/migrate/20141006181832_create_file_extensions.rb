class CreateFileExtensions < ActiveRecord::Migration
  def change
    create_table :file_extensions do |t|
      t.string :extension, null: false
      t.boolean :process_tag, null: false, default: false

      t.timestamps
    end
  end
end
