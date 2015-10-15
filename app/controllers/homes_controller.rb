class HomesController < ApplicationController
  before_filter :no_footer
  def index
  end

  private

  def no_footer
    @no_footer = true
  end
end
