class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # # before_action :configure_account_update_params, only: [:update]
  # before_action :set_user
  before_action :validates_step1, only: :phone
  before_action :validates_step2, only: :phone_authe
  before_action :validates_step3, only: :create

  def new
  end
# frozen_string_literal: true
  # GET /resource/sign_up
  def new_registration
    @user = User.new
  end

  # POST /resource
  def profile
    @user = User.new
  end

  def sms
    @user = User.new
  end

  def sms_confirmation
    @user = User.new
  end

  def address
    @streetaddress = StreetAddress.new
  end

  def validates_step1
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:encrypted_password] = user_params[:encrypted_password]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birth_year] = params[:birth_date][:"birthday(1i)"]
    session[:birth_month] = params[:birth_date][:"birthday(2i)"]
    session[:birth_day] = params[:birth_date][:"birthday(3i)"]
    #バリデーション用に、仮でインスタンスを作成
    @user = User.new(
      nickname: session[:nickname], #sessionに保存された値を返す
      email: session[:email],
      password: session[:password],
      encrypted_password: session[:encrypted_password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      #入力前の情報はバリデーションに通る値を仮で入れておく
      phone_number: "12345678910"
    )
    render 'profile' unless @user.valid?(:validates_step1)
  end

  def validates_step2
    session[:phone_number] = user_params[:phone_number]
    @user = User.new(
      nickname: session[:nickname], #sessionに保存された値を返す
      email: session[:email],
      password: session[:password],
      encrypted_password: session[:encrypted_password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      phone_number: session[:phone_number]
    )
    render 'phone' unless @user.valid?(:validates_step2)
  end

  def validates_step3
    session[:address_last_name] = address_params[:address_last_name]
    session[:address_first_name] = address_params[:address_first_name]
    session[:address_last_name_kana] = address_params[:address_last_name_kana]
    session[:address_first_name_kana] = address_params[:address_first_name_kana]
    session[:post_number] = address_params[:post_number]
    session[:prefectures] = address_params[:prefectures]
    session[:city] = address_params[:city]
    session[:house_number] = address_params[:house_number]
    session[:building_name] = address_params[:building_name]
    session[:address_phone_number] = address_params[:address_phone_number]
    @street_address = StreetAddress.new(
      address_last_name: session[:address_last_name],
      address_first_name: session[:address_first_name],
      address_last_name_kana: session[:address_last_name_kana],
      address_first_name_kana: session[:address_first_name_kana],
      post_number: session[:post_number],
      prefectures: "千葉県",
      city: session[:city],
      house_number: session[:house_number],
      building_name: session[:building_name],
      address_phone_number: session[:address_phone_number]
    )
    render 'address' unless @street_address.valid?(:validates_step3)
  end

  # 新規登録時のクレカと登録未実装の為
  # def credit
  #   # render layout: "application.registration" 
  #   # session[:address_attributes] = user_params[:address_attributes]
  # end

  def complete
    # sign_in User.find(session[:id]) unless user_signed_in?
    # session[:credit_attributes] = user_params[:credit_attributes]
    # session[:address_attributes] = user_params[:address_attributes]
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      encrypted_password: session[:encrypted_password],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      phone_number: session[:phone_number]
    )
    @street_address = StreetAddress.new(
      address_last_name: session[:address_last_name],
      address_first_name: session[:address_first_name],
      address_last_name_kana: session[:address_last_name_kana],
      address_first_name_kana: session[:address_first_name_kana],
      post_number: session[:post_number],
      prefectures: session[:prefectures],
      city: session[:city],
      house_number: session[:house_number],
      building_name: session[:building_name],
      address_phone_number: session[:address_phone_number]
    )
    if @user.save!
      session[:id] = @user.id
      @street_address.save!
      redirect_to complete_path
    else
      render 'new'
    end
  end
    
  #   if @user.save
  #     session[:id] = @user.id
  #     sign_in User.find(session[:id]) unless user_signed_in?
  #     # session.clear
  #     redirect_to root_path
  #   else
  #     # session.clear
  #     redirect_to profile_path
  #   end
  # end


  protected

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :encrypted_password,
      :password,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :phone_number,
      
    ) 
  end

  def address_params
    params.require(:street_address).permit(
      :address_first_name,
      :address_last_name,
      :address_last_name_kana,
      :address_first_name_kana,
      :post_number,
      :prefectures,
      :city,
      :house_number,
      :building_name,
      :address_phone_number
    )
    
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
