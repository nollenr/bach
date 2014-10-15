class ChangeTrackToIntegerInLibaryFileSpec < ActiveRecord::Migration
  def change
    change_column :library_file_specs, :track, 'integer USING CAST(track AS integer)'
  end
end
