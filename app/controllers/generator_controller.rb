class GeneratorController < ApplicationController
  def index
    @pages = Page.all.sort
  end
  
  
end
