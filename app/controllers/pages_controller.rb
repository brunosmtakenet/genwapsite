class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end
  
  def edit_multiple
    @pages = Page.all.sort
    
  end
  
  def update_multiple
    @pages = Page.all.sort
     
    @pages.each do |page|
      page.title = params["Title#{page.id}"]
      page.content = params["Content#{page.id}"]
      page.check_order if page.valid?
      page.save
    end
    
    redirect_to(edit_multiple_path, :notice => "Pages Updated!")
  end
  
  def preview
    @layout = Layout.find_by_active(true)
    @pages = Page.all.sort
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new()
    @page.title = "Nova Pagina"
    @page.content = "Coloque conteudo aqui."
    @page.push_back
    
    respond_to do |format|
      if @page.save
        format.html { redirect_to(edit_multiple_path, :notice => 'Page was successfully created.') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    if params[:shift] == "left"
      @page.order -= 1  
    elsif params[:shift] == "right"
      @page.order += 1
    end
    
    @page.check_order 
    
    respond_to do |format|
      if @page.save
        format.html { redirect_to(edit_multiple_path, :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.remove_page 
    
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(edit_multiple_path) }
      format.xml  { head :ok }
    end
  end
  
end
