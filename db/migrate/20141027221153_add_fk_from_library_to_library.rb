class AddFkFromLibraryToLibrary < ActiveRecord::Migration
  def change


    reversible do |stmnt|
      stmnt.up do
        # add a foreign key
        execute <<-SQL
          ALTER TABLE libraries
            ADD CONSTRAINT "FK001" FOREIGN KEY (idofparent) REFERENCES libraries (id)
             ON UPDATE NO ACTION ON DELETE NO ACTION
        SQL
      end #stmnt.up

      stmnt.down do
        # drop foreign key
        execute <<-SQL
          ALTER TABLE libraries
            DROP CONSTRAINT "FK001"
        SQL
      end # stmnt.down

    end # reversible

  end
end
