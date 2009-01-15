require 'mongo_record'

class Address < MongoRecord::Subobject

  fields :street, :city, :state, :postal_code
  belongs_to :student

  def to_s
    "#{street}\n#{city}, #{state} #{postal_code}"
  end

end
