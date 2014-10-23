class CreateFileNameingSequences < ActiveRecord::Migration
  def change
    execute 'create sequence artist_seq'
    execute 'create sequence album_seq'
    execute 'create sequence title_seq'
  end
end
