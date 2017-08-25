class Vineyard < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods
  has_many :wines
  belongs_to :user
end
