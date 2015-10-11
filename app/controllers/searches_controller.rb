class SearchesController < ApplicationController
  def new
    @search = Search.new
    @user = current_user
  end

  def create
    @search = Search.create(search_params)
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
  end

  private

  def search_params
    params.require(:search).permit(
      :dog_friendly,
      :cat_friendly,
      :kid_friendly,
      :city,
      :state,
      :name,
      :email,
      :rescue_group
    )
  end
end
