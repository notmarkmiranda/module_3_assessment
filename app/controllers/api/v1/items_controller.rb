class Api::V1::ItemsController < Api::ApiController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def create
    respond_with Item.create(item_params)
  end

  def destroy
    respond_with status: 204 if Item.delete(params[:id])
  end

  private
    def item_params
      params.permit(:name, :description, :image_url)
    end
end
