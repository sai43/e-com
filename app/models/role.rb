class Role < ApplicationRecord

  has_many :users_roles
  has_many :users, through: :users_roles
  belongs_to :resource, polymorphic: true, optional: true

  validates_presence_of :resource_type, :resource_id

  scopify

  def as_json(options={})
    super({include: {resource: {only: [:name]}}}.merge(options || {}))
  end

end
