class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,                   :type => String, :default => ""
  field :encrypted_password,      :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at,    :type => Time

  ## Trackable
  field :sign_in_count,          :type => Integer, :default => 0
  field :current_sign_in_at,     :type => Time
  field :last_sign_in_at,        :type => Time
  field :current_sign_in_ip,     :type => String
  field :last_sign_in_ip,        :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
  embeds_many :projects, inverse_of: :user, :class_name => "MemberOf"
  embeds_one  :profile
end

class MemberOf
    include Mongoid::Document
    embedded_in :user, inverse_of: :project, :class_name => "User"
    belongs_to :project, inverse_of: :members, :class_name => "Project"
    field :score,     :type => Integer, :default => 0
end

class Profile
  include Mongoid::Document
  embedded_in :user
  field :full_name,         :type => String
  field :s_number,          :type => String
  field :bio,               :type => String
  field :company,           :type => String
  field :school,            :type => String
  embeds_many :phone_numbers, inverse_of: :profile, :class_name => "PhoneNumber"
end

class PhoneNumber
  include Mongoid::Document
  embedded_in :profile, inverse_of: :phone_number, :class_name => "Profile"
  field :type,            type: Symbol 
  validates_inclusion_of :type, in: [:work, :mobile, :home]
end
