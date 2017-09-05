class User < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods
  has_secure_password
  has_many :vineyards
  has_many :wines

  validates :username, presence: true, uniqueness: true
end
