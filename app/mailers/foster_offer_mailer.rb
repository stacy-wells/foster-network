class FosterOfferMailer < ApplicationMailer
  def new_foster_offer(foster_offer)
    @foster_offer = foster_offer
    @rescue_group = User.find(foster_offer.animal_rescue_id)
    @foster = foster_offer.user
    @animal = foster_offer.animal

    mail(
      to: @rescue_group.email,
      subject: "New foster offer for #{@animal.name}"
    )
  end
end
