class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @fosters = @user.fosters
    @animals = current_user.animals
  end
end
