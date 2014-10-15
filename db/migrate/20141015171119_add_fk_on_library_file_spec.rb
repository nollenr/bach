class AddFkOnLibraryFileSpec < ActiveRecord::Migration
  def change
    reversible do |stmnt|
      stmnt.up do
        # add a foreign key
        execute <<-SQL
          ALTER TABLE library_file_specs
            ADD CONSTRAINT "FK002" FOREIGN KEY (file_extension) REFERENCES file_extensions (extension)
             ON UPDATE NO ACTION ON DELETE NO ACTION
        SQL
      end #stmnt.up

      stmnt.down do
        # drop foreign key
        execute <<-SQL
          ALTER TABLE library_file_specs
            DROP CONSTRAINT "FK002"
        SQL
      end # stmnt.down

    end # reversible

  end
end
