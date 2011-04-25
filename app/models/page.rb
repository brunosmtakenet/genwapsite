class Page < ActiveRecord::Base
  def <=>(u)
    self.order <=> u.order
  end
end
