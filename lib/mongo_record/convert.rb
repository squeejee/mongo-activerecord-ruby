#--
# Copyright (C) 2009 10gen Inc.
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
#++

# Mongo stores trees of JSON-like documents. These +to_mongo_value+ methods
# covert objects to Hash values, which are converted by the Mongo driver
# to the proper types.

class Object
  # Convert an Object to a Mongo value. Used by MongoRecord::Base when saving
  # data to Mongo.
  def to_mongo_value
    self
  end
end

class Array
  # Convert an Array to a Mongo value. Used by MongoRecord::Base when saving
  # data to Mongo.
  def to_mongo_value
    self.collect {|v| v.to_mongo_value}
  end
end

class Hash
  # Convert an Hash to a Mongo value. Used by MongoRecord::Base when saving
  # data to Mongo.
  def to_mongo_value
    h = {}
    self.each {|k,v| h[k] = v.to_mongo_value}
    h
  end
end
