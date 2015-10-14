class AnimalsController < ApplicationController
  before_action :authenticate_user!
  def index
    @animals = Animal.all.where(fostered_by: nil)
    @foster_offer = FosterOffer.new
  end

  def show
    @animal = Animal.find(params[:id])
    @offers = FosterOffer.where(animal_id: @animal.id)
  end

  def new
    @animal = Animal.new
    @age_options = Animal.age_options
  end

  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      flash[:alert] = "#{@animal.name} has been added!"
      redirect_to user_path(current_user)
    else
      flash[:errors] = @animal.errors.full_messages.join(".  ")
      @age_options = Animal.age_options
      render :new
    end
  end

  def edit
    @animal = Animal.find(params[:id])
    @age_options = Animal.age_options

    if current_user.id != @animal.animal_rescue_id
      flash[:errors] = "We're sorry.  You don't have permission to update
                       this animal."
      redirect_to root_path
    end
  end

  def update
    @animal = Animal.find(params[:id])
    @age_options = Animal.age_options

    if current_user.id != @animal.animal_rescue_id
      flash[:errors] = "We're sorry.  You don't have permission to update
                        this animal."
      redirect_to root_path
    end

    if @animal.update(animal_params)
      if animal_params.include?(:fostered_by_id) &&
         animal_params[:fostered_by_id] != ""
        AcceptFosterMailer.accept_foster(@animal).deliver_later
      end
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

  def petfinder_add_all
    @animal = Animal.new
  end

  def petfinder_get_all
    response = HTTParty.get("http://api.petfinder.com/shelter.getPets?key=51e64f23d75e66c25b373ab9ada9943f&id=#{params["animal"]["shelter_id"]}")
    animals = response["petfinder"]["pets"]["pet"]

    cats = nil
    dogs = nil

    animals.each do |animal|
      if animal["animal"] == "Dog"
        if animal["options"]["option"].include?("noCats")
          cats = false
        end

        if animal["options"]["option"].include?("noDogs")
          dogs = false
        end

        Animal.create!(
          animal_rescue_id: current_user.id,
          shelter_id: animal["shelterId"],
          name: animal["name"],
          animal: animal["animal"],
          age: animal["age"],
          sex: animal["sex"],
          dog_friendly: dogs,
          cat_friendly: cats,
          description: animal["description"],
          photo: animal["media"]["photos"]["photo"][2]["__content__"],
          status: animal["status"]
          )
      end
    end
    flash[:notice] = "Your animals have been added."
    redirect_to user_path(current_user)
  end

  private

  def animal_params
    params.require(:animal).permit(
      :name,
      :animal,
      :sex,
      :age,
      :description,
      :dog_friendly,
      :cat_friendly,
      :animal_photo,
      :fostered_by_id,
      :shelter_id,
      :status
      ).merge(
        animal_rescue_id: current_user.id
      )
  end
end
