class UsersController < ApplicationController
  before_action :authenticate_user!

  before_filter :no_footer, :only => [:show]

  def show
    @user = User.find(params[:id])
    @fosters = @user.fosters
    @user_animals = current_user.animals
    @unfostered_animals = get_unfostered_animals
    @offers = FosterOffer.all
    @fostered_animals = get_fostered_animals
  end

  private

  def no_footer
    @no_footer = true
  end

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
