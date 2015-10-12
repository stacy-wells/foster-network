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

  def send_mail
    @search = Search.find(params[:id])
    @potential_fosters = @search.search_users
    @potential_fosters.each do |user|
      FosterOfferMailer.get_foster_offer(user, current_user).deliver_later
    end
    flash[:notice] = "#{@potential_fosters.count} user(s) have been emailed!."
    redirect_to :back
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
