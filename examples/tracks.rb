# Use the local copy, even if this gem is already installed.
$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '../lib')

require 'rubygems'
require 'mongo'
require 'mongo_record'

class Track < MongoRecord::Base
  collection_name :tracks
  fields :artist, :album, :song, :track
  def to_s
    # Uses both accessor methods and ivars themselves
    "artist: #{artist}, album: #{album}, song: #@song, track: #{@track ? @track.to_i : nil}"
  end
end

MongoRecord::Base.connection = XGen::Mongo::Driver::Mongo.new.db('mongorecord-test')

# Create data

puts "Creating 6 records using \"raw\" Mongo access..."
db = MongoRecord::Base.connection
coll = db.collection('tracks')
coll.remove({})
coll.insert({:_id => XGen::Mongo::Driver::ObjectID.new, :artist => 'Thomas Dolby', :album => 'Aliens Ate My Buick', :song => 'The Ability to Swing'})
coll.insert({:_id => XGen::Mongo::Driver::ObjectID.new, :artist => 'Thomas Dolby', :album => 'Aliens Ate My Buick', :song => 'Budapest by Blimp'})
coll.insert({:_id => XGen::Mongo::Driver::ObjectID.new, :artist => 'Thomas Dolby', :album => 'The Golden Age of Wireless', :song => 'Europa and the Pirate Twins'})
coll.insert({:_id => XGen::Mongo::Driver::ObjectID.new, :artist => 'XTC', :album => 'Oranges & Lemons', :song => 'Garden Of Earthly Delights', :track => 1})
coll.insert({:_id => XGen::Mongo::Driver::ObjectID.new, :artist => 'XTC', :album => 'Oranges & Lemons', :song => 'The Mayor Of Simpleton', :track => 2})
song_id = XGen::Mongo::Driver::ObjectID.new
coll.insert({:_id => song_id, :artist => 'XTC', :album => 'Oranges & Lemons', :song => 'King For A Day', :track => 3})
puts "Data created. One song_id = #{song_id}."
puts "There are #{coll.count()} records in the tracks collection."


puts "\nSimple find"
puts Track.find(song_id).to_s
puts Track.find(song_id, :select => :album).to_s
puts Track.find_by_id(song_id).to_s
puts Track.find_by_song("Budapest by Blimp").to_s

puts "\nCount"
puts "Yup; there are indeed #{Track.count} records in the tracks collection."

puts "\nUpdate"
x = Track.find_by_track(2)
x.track = 99
x.save
puts Track.find_by_track(99).to_s

puts "\nComplex find"
puts Track.find_by_song('The Mayor Of Simpleton').to_s

puts "\nFind all"
Track.find(:all).each { |t| puts t.to_s }

puts "\nFind song /to/"
Track.find(:all, :conditions => {:song => /to/}).each { |row| puts row.to_s }

puts "\nFind limit 2"
Track.find(:all, :limit => 2).each { |t| puts t.to_s }

puts "\nFind by album"
Track.find(:all, :conditions => {:album => 'Aliens Ate My Buick'}).each { |t| puts t.to_s }

puts "\nFind first"
puts Track.find(:first).to_s

puts "\nFind track 3"
puts Track.find(:first, :conditions => {:track => 3}).to_s

puts "\nfind_by_album"
Track.find_all_by_album('Oranges & Lemons').each { |t| puts t.to_s }

puts "\nSorting"
Track.find(:all, :order => 'album desc').each { |t| puts t.to_s }

puts "\nTrack.new"

puts Track.new.to_s

t = Track.new(:artist => 'Level 42', :album => 'Standing In The Light', :song => 'Micro-Kid', :track => 1)
puts t.to_s
puts "save returned #{t.save}"

puts "\nTrack.find_or_create_by_song"

s, a = 'The Ability to Swing', 'ignored because song found'
puts Track.find_or_create_by_song(s, :artist => a).to_s

s, ar, al = 'New Song', 'New Artist', 'New Album'
puts Track.find_or_create_by_song(s, :artist => ar, :album => al).to_s

puts "\nTrack.find(:first, :conditions => {:song => 'King For A Day'}).delete"
t = Track.find(:first, :conditions => {:song => 'King For A Day'}).delete
Track.find(:all).each { |t| puts t.to_s }

puts "\nTrack.find('bogus_id')"
puts "I should see an exception here:"
begin
  Track.find('bogus_id')
rescue => ex
  puts ex.to_s
end

puts "\nexplain()"
puts Track.find(:all, :conditions => {:song => 'King For A Day'}).explain().inspect
