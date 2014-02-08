class Project
  include Mongoid::Document

  #Project Info
  field :name,              :type => String
  field :school,            :type => String
  field :desc,              :type => String
  field :ext_link,          :type => String
  field :budget,            :type => Integer

  # embeds_many :projectimages
  
  # #Menbers
  # has_one :menber, as: :team_lead
  # has_one :member,  as: :project_created_by
  # embeds_many :members
  
  # #project contraints
  # embeds_many :milestones

end

class Member
    include Mongoid::Document
    embedded_in :project
    belongs_to :team_lead, polymorphic: true, validate: false
    belongs_to :project_created_by, polymorphic: true, validate: false
    belongs_to :user, polymorphic: true

    field :user_name,             :type => String
end 

class Milestone 
    include Mongoid::Document

    field :milestone_name,       :type => String
    field :milestone_deadline,   :type => Date


    embedded_in :project
end 

class ProjectImage
    include Mongoid::Document
    embedded_in :project
    field :image_name,       :type => String
    has_one :project_image_data, as: :image_data
end 
