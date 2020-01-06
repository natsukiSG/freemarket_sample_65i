class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorization(:facebook)
  end

  def google_oauth2
    authorization(:google)
  end

  private
  def authorization(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?  #もし@userがDBに既にいたら、ログイン状態にします  
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else  #もし@userがDBにいない場合、新規登録ページにリダイレクトします
      session["devise.provider_data"] = request.env["omniauth.auth"].except(:extra)
      #データをsessionに入れることによって、新規登録ページの入力欄に、予め情報を入れておくなどが可能になります。
      session[:password] = SecureRandom.alphanumeric(30)
      redirect_to profile_path
    end
  end
end