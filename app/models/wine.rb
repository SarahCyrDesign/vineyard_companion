class Wine < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods
  belongs_to :vineyard
  belongs_to :user
end
