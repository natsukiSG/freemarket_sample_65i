class Users::SessionsController < Devise::SessionsController
  prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :customize_sign_up_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # # POST /resource/sign_in
  # # def create
  # #   super
  # # end


  # # DELETE /resource/sign_out
  def destroy
    super
  end

  private
  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_in, keys: [:username, :email, :password, :password_confirmation]
  end

  def check_captcha
    self.resource = resource_class.new sign_in_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
  end
end
