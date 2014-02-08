class Image
  include Mongoid::Document
  
  field :image_binary,       :type => BSON::Binary
  belongs_to :image_data, polymorphic: true
end
