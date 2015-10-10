class FosterOffersController < ApplicationController
  def create
    @foster_offer = FosterOffer.create!(foster_offer_params)

    if @foster_offer.save
      FosterOfferMailer.new_foster_offer(@foster_offer).deliver_later
      flash[:alert] = "#{get_rescue_name} has been notified!"
      redirect_to animals_path
    else
      flash[:errors] = @foster_offer.errors.full_messages.join(".  ")
      render animals_path
    end
  end

  private

  def foster_offer_params
    params.require(:foster_offer).permit(:user_id, :animal_id, :animal_rescue_id)
  end

  def get_rescue_name
    @animal = Animal.find(params[:foster_offer]["animal_id"])
    rescue_group = User.find(@animal.animal_rescue_id)
    rescue_group.name
  end
end
