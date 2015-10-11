class AcceptFosterMailer < ApplicationMailer
  def accept_foster(animal)
    @animal = animal
    @foster = User.find(@animal.fostered_by_id)
    @rescue_group = User.find(@animal.animal_rescue_id)

    mail(
      to: @foster.email,
      subject: "#{@rescue_group.name} has accepted your offer to foster!"
    )
  end
end
