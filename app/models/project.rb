class Project
  include Mongoid::Document

  #Project Info
  field :name,              :type => String
  field :school,            :type => String
  field :desc,              :type => String
  field :ext_link,          :type => String

  field :budget,            :type => Integer

  #Menbers
  field :lead,              :type => String

  embeds_many :member
  embeds_many :image
  embeds_many :milestone

end

class menber
    include Mongoid::Document
    embedded_in :project
    field :user,             :type => String
    field :lead,             :type => String
end 

class milestone 
    include Mongoid::Document

    field :milestone_name,       :type => String
    field :milestone_deadline,   :type => Date


    embedded_in :project
end 

class image
    include Mongoid::Document
    embedded_in :project
    field :image_name,       :type => String
    field :image_data,       :type => Moped::BSON::Binary
end 
