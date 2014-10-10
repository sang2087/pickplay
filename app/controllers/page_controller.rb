class PageController < ApplicationController
  def index
    if user_signed_in?
      redirect_to "/main"
    end
  end

  def main
    @games = Game.all

  end

  def detail
  end
end
