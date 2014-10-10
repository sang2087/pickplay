class PageController < ApplicationController
  layout :resolve_layout
  before_filter :login_check, :except => ["index"]
  def login_check
    unless user_signed_in?
      redirect_to "/"
    end
  end

  def index
    if user_signed_in?
      if current_user.ratings.length == 0
        redirect_to "/select"
      else
        redirect_to "/main"
      end
    end
  end

  def main
    @games = Game.get_platform_game current_user
  end

  def detail
  end

  def my_wish
    @wishes = current_user.wishes
    @ratings = current_user.ratings
  end
  def select
    @games = Game.all.shuffle
  end


private
  def resolve_layout
    case action_name
    when "index"
      "application"
    else
      "main"
    end
  end
end
