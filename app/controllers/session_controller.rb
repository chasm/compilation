class SessionController < ApplicationController
  # GET /login - user log in form
  def new
    @user = User.new
  end

  # POST /login - log user in
  def create
    # Is email blank?
    if (params[:user][:email].blank?)
      # If yes, rerender the form with error message
      flash.now[:error] = "You must enter an email address"
      render :new
    else
      # If no, does user exist?
      if @user = User.find_by(email: params[:user][:email])
        # If yes, is password blank?
        if (params[:user][:password].blank?)
          # If yes, send password reset email and redirect with msg
          # Set code and expires_at and save user
          @user.code = SecureRandom.urlsafe_base64
          @user.expires_at = Time.now + 4.hours
          @user.save
          
          # Send code email
          PasswordMailer.reset_email(@user).deliver
          
          redirect_to login_url, notice: "A password reset email has been sent."
        else
          # If no, authenticate user
          # TODO: write authenticate method in user model
          if @user.authenticate(params[:user][:email])
            # If authenticated, log in and redirect to /
            puts "Redirecting to root url"
            session[:user_id] = @user.id
            redirect_to root_url
          else
            # If auth fails, render login page with error
            flash.now[:error] = "Wrong email or password. Try again?"
            render :new
          end
        end
      else
        # If no, redirect to registration form
        redirect_to register_url, notice: "Please register."
      end
    end
  end

  # GET/DELETE /logout - logs user out
  def destroy
  end
end
