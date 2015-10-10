class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @fosters = @user.fosters
    @user_animals = current_user.animals
    @unfostered_animals = get_unfostered_animals
    @offers = FosterOffer.all
    @fostered_animals = get_fostered_animals
  end

  private

  def get_fostered_animals
    array = []
    @user_animals.each do |animal|
      if !animal.fostered_by_id.nil?
        array << animal
      end
    end
    array
  end

  def get_unfostered_animals
    array = []
    @user_animals.each do |animal|
      if animal.fostered_by_id.nil?
        array << animal
      end
    end
    array
  end
end
