class Membership
    include Mongoid::Document
    belongs_to :owner, inverse_of: :membership, :class_name => "User"
    has_and_belongs_to_many :projects, inverse_of: :members, :class_name => "Project"

    field :totalStore,     :type => Integer, :default => 0



end
