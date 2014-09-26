class AddFkOnLibaryFileSpecs < ActiveRecord::Migration
  def change

    reversible do |stmnt|
      stmnt.up do
        # add a foreign key
        execute <<-SQL
          ALTER TABLE library_file_specs
            ADD CONSTRAINT "FK001" FOREIGN KEY (idoflibraryrecord) REFERENCES libraries (id)
             ON UPDATE NO ACTION ON DELETE NO ACTION
        SQL
      end #stmnt.up

      stmnt.down do
        # drop foreign key
        execute <<-SQL
          ALTER TABLE library_file_specs
            DROP CONSTRAINT "FK001"
        SQL
      end # stmnt.down

    end # reversible
  end # change
end
