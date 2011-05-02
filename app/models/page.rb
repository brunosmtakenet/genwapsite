class Page < ActiveRecord::Base
 
  validates :title, :presence => true
  validates :order, :presence => true, :numericality => {:greater_than_or_equal_to => 1}
  
  def check_order
      max_order = Page.maximum(:order)
      if self.order > max_order
        self.order = max_order
      end
      if self.order == 0
        self.order += 1
      end
      
      current = Page.find(self.id) 
      if(self.order > current.order)
        shift(current.order+1, self.order,-1)
      elsif(self.order < current.order)
        shift(self.order, current.order-1,1)
      end
  end
  
  def shift(start, finish , offset)
    for i in start..finish
      currentPage = Page.find_by_order(i)
      currentPage.order += offset
      currentPage.save
    end
  end
  
  def remove_page
    max_order = Page.maximum(:order)
    shift(self.order, max_order, -1)
  end
  
  def push_back
    max_order = Page.maximum(:order)
    if max_order.nil?
      self.order = 1
    else
      self.order = max_order + 1
    end
  end
  
  def <=>(u)
    self.order <=> u.order
  end
  
end
