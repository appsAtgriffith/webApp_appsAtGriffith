class Project
  include Mongoid::Document

  #Project Info
  field :name,              :type => String
  field :description,       :type => String
  field :comment,           :type => String
  field :external_link,     :type => String
  field :budget,            :type => Integer
  field :due_date,          :type => Date

  # #Menbers
  field :team_lead_id,      :type => BSON::ObjectId
  field :created_by_id,     :type => BSON::ObjectId
  has_many :members, inverse_of: :projects, :class_name => "Membership"
  

  #history
  field :current_state_id,      :type => BSON::ObjectId
  field :created_by_id,     :type => BSON::ObjectId
  embeds_many :history


  #links to team_lead_id
  def team_lead
    self.team_lead_id
  end
  #Links to the creator user
  def creator
    self.project_created_id
  end
  #will get the current state from history
  def current_state
    history.where(current_state_id)
  end
  #will get the date at which the document 
  #as created
  def created_on
    history.where(created_by_id)
  end
  # #project contraints
  # embeds_many :milestones
end

class History 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type,                  type: Symbol 
  validates_inclusion_of :type, in: [:created, :dormant, :active, :cloased]
end