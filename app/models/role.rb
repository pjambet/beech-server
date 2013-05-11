# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  attr_accessible :name

  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: true

  class << self
    def admin_role
      Role.find_or_create_by(name: 'admin')
    end
  end
end

