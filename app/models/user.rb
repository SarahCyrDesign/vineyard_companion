class User < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods
  has_secure_password
  has_many :vineyards
  has_many :wines

  def vineyards_sort_by_name
  self.vineyards.all.sort_by {|vineyard| vineyard[:name]}
end
end
