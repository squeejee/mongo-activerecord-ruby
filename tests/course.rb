class Course < MongoRecord::Base

  # Declare Mongo collection name and ivars to be saved
  collection_name :courses
  field :name

  def to_s
    "Course #{name}"
  end
end
