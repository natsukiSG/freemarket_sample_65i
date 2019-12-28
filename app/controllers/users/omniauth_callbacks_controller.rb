class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?  #もし@userがDBに既にいたら、ログイン状態にします  
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else  #もし@userがDBにいない場合、新規登録ページにリダイレクトします
      session["devise.provider_data"] = request.env["omniauth.auth"]
      #データをsessionに入れることによって、新規登録ページの入力欄に、予め情報を入れておくなどが可能になります。
      session[:password] = SecureRandom.alphanumeric(30)
      # binding.pry
      redirect_to profile_path
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: 'google') if is_navigational_format?
    else
      session["devise.provider_data"] = request.env["omniauth.auth"][:info]
      #google認証の場合は、なぜかauth_hashの容量が大きく、一瞬で容量オーバーとなるため、新規登録時に必要な情報のみをsessionに渡すこととしました。（おそらく画像データのせい？）
      redirect_to profile_path
    end
  end
end
# frozen_string_literal: true