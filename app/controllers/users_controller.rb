class UsersController < ApplicationController
  def show
    @user = current_user
    @card = Creditcard.find_by(user_id: current_user.id)
  end

  # マイページ/設定
  def profile
    @user = User.find(params[:id])
  end

  def address
    @streetaddress = Streetaddress.find_by(user_id: current_user.id)
  end

  def mail_password
    @user = User.find(params[:id])
  end

  def preview
    @user = User.find(params[:id])
    @streetaddress = Streetaddress.find_by(user_id: current_user.id)
  end

  def sms_confirmation

  end
  
  def logout
  end
  
  def info_check
    @streetaddress = StreetAddress.find_by(user_id: current_user.id)
  end
end
