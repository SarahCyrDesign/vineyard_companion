class User < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods
  has_secure_password
  has_many :vineyards
  has_many :wines

  validates :username, presence: true, uniqueness: true

  def vineyards_sort_by_name
    self.vineyards.all.sort_by {|vineyard| vineyard[:name]}
  end

  def wines_sort_by_name
    self.wines.all.sort_by {|wine| wine[:name]}
  end
end
