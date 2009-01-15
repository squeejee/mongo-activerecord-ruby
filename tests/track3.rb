require 'mongo_record/base'

class Track3 < MongoRecord::Base
  collection_name :tracks
  fields :artist, :album, :song, :track
  def to_s
    "artist: #{artist}, album: #{album}, song: #{song}, track: #{track ? track.to_i : nil}"
  end
end
