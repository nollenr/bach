class AddAudioPropertiesToLibraryFileSpec < ActiveRecord::Migration
  def change
    add_column :library_file_specs, :bitrate, :integer
    add_column :library_file_specs, :channels, :integer
    add_column :library_file_specs, :sample_rate, :integer
  end
end
