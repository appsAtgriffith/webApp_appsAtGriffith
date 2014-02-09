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
  field :team_lead_id,      :type => BSON::ObjectId
  field :created_by_id,     :type => BSON::ObjectId
  has_and_belongs_to_many :members, inverse_of: :projects, :class_name => "Membership"
  




  #links to team_lead_id

  def team_lead
    memberships.where(self.team_lead_id)
  end

  def project_created
    memberships.where(self.project_created_id)
  end
  # #project contraints
  # embeds_many :milestones
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
