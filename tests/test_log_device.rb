# Copyright (C) 2008 10gen Inc.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License, version 3, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
# for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '../lib')
require 'rubygems'
require 'test/unit'
require 'logger'
require 'mongo'
require 'mongo_record/log_device.rb'

class LoggerTest < Test::Unit::TestCase

  MAX_RECS = 3

  @@host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
  @@port = ENV['MONGO_RUBY_DRIVER_PORT'] || XGen::Mongo::Driver::Mongo::DEFAULT_PORT
  @@db = XGen::Mongo::Driver::Mongo.new(@@host, @@port).db('mongorecord-test')

  def setup
    @@db.drop_collection('testlogger') # can't remove recs from capped colls
    MongoRecord::LogDevice.connection = @@db
    # Create a log device with a max of MAX_RECS records
    @logger = Logger.new(MongoRecord::LogDevice.new('testlogger', :size => 1_000_000, :max => MAX_RECS))
  end

  def teardown
    @@db.drop_collection('testlogger') # can't remove recs from capped colls
  end

  # We really don't have to test much more than this. We can trust that Mongo
  # works properly.
  def test_max
    assert_not_nil @@db
    assert_equal @@db.name, MongoRecord::LogDevice.connection.name
    collection = MongoRecord::LogDevice.connection.collection('testlogger')
    MAX_RECS.times { |i|
      @logger.debug("test message #{i+1}")
      assert_equal i+1, collection.count()
    }

    MAX_RECS.times { |i|
      @logger.debug("test message #{i+MAX_RECS+1}")
      assert_equal MAX_RECS, collection.count()
    }
  end

  def test_alternate_connection
    old_db = @@db
    alt_db = XGen::Mongo::Driver::Mongo.new(@@host, @@port).db('mongorecord-test-log-device')
    begin
      @@db = nil
      MongoRecord::LogDevice.connection = alt_db

      logger = Logger.new(MongoRecord::LogDevice.new('testlogger', :size => 1_000_000, :max => MAX_RECS))
      logger.debug('test message')

      coll = alt_db.collection('testlogger')
      assert_equal 1, coll.count()
      rec = coll.find_first({}, :limit => 1)
      assert_not_nil rec
      assert_match /test message/, rec['msg']
    rescue => ex
      fail ex.to_s
    ensure
      @@db = old_db
      MongoRecord::LogDevice.connection = @@db
      alt_db.drop_collection('testlogger')
    end
  end

end
