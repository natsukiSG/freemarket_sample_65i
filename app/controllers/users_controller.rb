class UsersController < ApplicationController
  def index
  end
  def show
  end
  def logout
  end
  def info_check
    @streetaddress = StreetAddress.find_by(user_id: current_user.id)
  end
end
