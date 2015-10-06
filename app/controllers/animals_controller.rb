class AnimalsController < ApplicationController
  def new
    @animal = Animal.new
    @age_options = age_options
    @size_options = size_options
  end

  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      flash[:alert] = "#{@animal.name} has been added!"
      redirect_to user_path(current_user)
    else
      flash[:errors] = @animal.errors.full_messages.join('.  ')
      @age_options = age_options
      @size_options = size_options
      render :new
    end
  end

  def age_options
    options = ["1-3 years", "3-6 years", "6-10 years", "10-14 years",
       "under a year", "over 15 years"]
    options
  end

  def size_options
    options = ["Extra Small: under 10lbs", "Small: 10lbs to 20lbs",
      "Medium: 21lbs to 40lbs", "Large: 41lbs to 74lbs",
      "Extra Large: Over 75lbs"]
    options
  end

  private

  def animal_params
    params.require(:animal).permit(
      :name,
      :species,
      :gender,
      :age,
      :size,
      :description,
      :fixed,
      :dog_friendly,
      :cat_friendly,
      :kid_friendly
      ).merge(
      animal_rescue_id: current_user.id
      )
  end
end
