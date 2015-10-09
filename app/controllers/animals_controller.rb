class AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def show
    @animal = Animal.find(params[:id])
  end

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
      flash[:errors] = @animal.errors.full_messages.join(".  ")
      @age_options = age_options
      @size_options = size_options
      render :new
    end
  end

  def edit
    @animal = Animal.find(params[:id])
    @age_options = age_options
    @size_options = size_options

    if current_user.id != @animal.animal_rescue_id
      flash[:errors] = "We're sorry.  You don't have permission to update
                       this animal."
      redirect_to root_path
    end
  end

  def update
    @animal = Animal.find(params[:id])

    if current_user.id != @animal.animal_rescue_id
      flash[:errors] = "We're sorry.  You don't have permission to update
                        this animal."
      redirect_to root_path
    end

    if @animal.update(animal_params)
      flash[:notice] = "#{@animal.name} has been updated!"
      redirect_to user_path(current_user)
    else
      flash[:errors] = @animal.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @animal = Animal.find(params[:id])

    if (current_user.id != @animal.animal_rescue_id)
      flash[:errors] = "I'm sorry, you don't have permission to delete this animal."
      redirect_to @animal
    end

    if @animal.destroy
      flash[:notice] = "#{@animal.name} has been deleted."
      redirect_to user_path(current_user)
    else
      flash[:errors] = @animal.errors.full_messages.join(". ")
      redirect_to @animal
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
      :kid_friendly,
      :animal_photo
      ).merge(
        animal_rescue_id: current_user.id
      )
  end
end
