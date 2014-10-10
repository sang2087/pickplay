class ApiController < ApplicationController
  def signin
    ret = false
    user = User.where(:email => params[:email]).first
    if !user.nil? and user.valid_password?(params[:password])
      sign_in(user)
      ret = true
    end
    render :json => ret
  end

  def signup
    ret = Hash.new
    ret[:result] = true
    unless User.where(:email => params[:email]).first.nil?
      ret[:result] = false
      ret[:message] = "이미 존재하는 이메일입니다."
    else
      user = User.create!({:email => params[:email],
                           :password => params[:password],
                           :password_confirmation => params[:password]})
      if user == false
        ret[:result] = false
        ret[:message] = "회원가입을 할 수 없습니다."
      else
        sign_in(user)
      end
    end
    render :json => ret
  end



  def game_info
    game = Game.find(params[:game_id])
    info = game.game_info.get_data
    comments = game.get_comment_data

    render :json => [game, info, comments]
  end

  def make_comment
    Comment.create(game_id: params[:game_id], content: params[:message], user_id: current_user.id)
    score = Game.find(params[:game_id]).rate current_user.id

    render :json => [score]
  end

  def set_rating
    Game.find(params[:game_id]).set_rate params[:score], current_user.id
    render :json => true
  end


end
