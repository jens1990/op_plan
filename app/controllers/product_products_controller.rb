class ProductProductsController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user
  # GET /product_products
  # GET /product_products.json
  def index
    @product_products = ProductProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_products }
    end
  end

  # GET /product_products/1
  # GET /product_products/1.json
  def show
    @product_product = ProductProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_product }
    end
  end

  # GET /product_products/new
  # GET /product_products/new.json
  def new
    @product_product = ProductProduct.new
  #  @product_product.build_from_product
  #  @product_product.build_to_product


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_product }
    end
  end

  # GET /product_products/1/edit
  def edit
    @product_product = ProductProduct.find(params[:id])
  end

  # POST /product_products
  # POST /product_products.json
  def create
    @product_product = ProductProduct.new(params[:product_product])
    respond_to do |format|
      if @product_product.save
        format.html { redirect_to @product_product, notice: 'Produkt wurde erfolgreich angelegt!' }
        format.json { render json: @product_product, status: :created, location: @product_product }
      else
        format.html { render action: "new" }
        format.json { render json: @product_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_products/1
  # PUT /product_products/1.json
  def update
    @product_product = ProductProduct.find(params[:id])

    respond_to do |format|
      if @product_product.update_attributes(params[:product_product])
        format.html { redirect_to @product_product, notice: 'Produkt   wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_products/1
  # DELETE /product_products/1.json
  def destroy
    @product_product = ProductProduct.find(params[:id])
    @product_product.destroy

    respond_to do |format|
      format.html { redirect_to product_products_url }
      format.json { head :no_content }
    end
  end
end


private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_path, notice: "Bitte melden Sie sich an."
  end
end