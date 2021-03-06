class CategoriesController < ApiController
  before_action :set_category, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.select(:id,:name)

    render json: @categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    render json: @category
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: {id:@category.id,name:@category.name} , status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      head :no_content
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy

    head :no_content
  end

  private

    def set_category
      @category = Category.select(:id,:name).find(params[:id])
    end

    def category_params
      params.permit(:name)
    end
end
