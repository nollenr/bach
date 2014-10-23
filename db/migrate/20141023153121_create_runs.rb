class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string    :process_name
      t.timestamp :run_date
      t.timestamps
    end

    reversible do |chgtbl|
      chgtbl.up do
       execute <<-SQL
         ALTER TABLE runs
           ADD COLUMN run_id serial;
       SQL
      end #chgtbl.up

      chgtbl.down do
        execute <<-SQL
          ALTER TABLE runs
            DROP COLUMN run_id;
        SQL
      end #chgtbl.down

    end #reversible
  end #change
end
