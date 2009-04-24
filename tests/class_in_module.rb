require 'mongo_record'

module MyMod
  class A < MongoRecord::Base
    field :something
  end
end

class B < MongoRecord::Base
  has_many :a, :class_name => "MyMod::A"
end
