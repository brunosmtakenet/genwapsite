module ApplicationHelper
  
  def is_preview?
    if params[:action] == "preview"
      return true
    else
      return false
    end
  end
    
end
