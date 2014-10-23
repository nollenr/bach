class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer     :run_id
      t.string      :process_name
      t.string      :log_message_type
      t.text        :log_message
      t.timestamps
    end

    reversible do |chgtbl|
      chgtbl.up do
       execute <<-SQL
         ALTER TABLE logs
           ADD COLUMN log_message_id serial;
       SQL
      end #chgtbl.up

      chgtbl.down do
        execute <<-SQL
          ALTER TABLE logs
            DROP COLUMN log_message_id;
        SQL
      end #chgtbl.down

    end #reversible
  end
end
