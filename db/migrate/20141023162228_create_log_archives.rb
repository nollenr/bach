class CreateLogArchives < ActiveRecord::Migration
  def change
    create_table :log_archives do |t|
      t.integer     :run_id
      t.integer     :log_message_id
      t.string      :process_name
      t.string      :log_message_type
      t.text        :log_message
      t.timestamps
    end
  end
end
