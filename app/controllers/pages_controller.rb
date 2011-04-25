class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all.sort

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

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to(edit_page_path(@page), :notice => 'Page was successfully created.') }
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
    
    initialOrder = @page.order
    
    
    # Verificar se o order q esta sendo colocado esta dentro do range. Se for maior corrigir aqui, se for menor q o range
    # (zero ou negativo) vai ser tratado via validaçoes no model.

    if Integer(params[:page][:order]) >= 10
      puts "AAAAA"
    end
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(edit_page_path(@page), :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
    
    shift = initialOrder - @page.order
   
    rearrange_order(shift, @page)
  
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(new_page_path) }
      format.xml  { head :ok }
    end
  end
  
  private
    
    def rearrange_order(shift, page)
      pages = Page.all.sort # trocar pelo @pages
      if shift > 0
        pages.each do |p|
          if p != page && p.order == page.order
            p.order = p.order + 1
            p.update_attributes(params[:p])
            rearrange_order(shift, p)
          end
        end
      elsif shift < 0
        pages.each do |p|
          if p != page && p.order == page.order
            p.order = p.order - 1
            p.update_attributes(params[:p])
            rearrange_order(shift, p)
          end
        end
      end
    end
    
end
