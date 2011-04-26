class Page < ActiveRecord::Base
  validates :title, :presence => true
  

  validates :order, :presence => true, :numericality => {:greater_than_or_equal_to => 1}
  
  def <=>(u)
    self.order <=> u.order
  end
  
  def include?
    return self.order.empty?
  end
end
