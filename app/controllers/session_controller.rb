class SessionController < ApplicationController
  # GET /login - user log in form
  def new
  end

  # POST /login - log user in
  def create
    # Is email blank?
    if (params[:email].blank?)
      # If yes, rerender the form with error message
      flash.now[:error] = "You must enter an email address"
      render :new
    else
      # If no, does user exist?
      if @user = User.find_by(email: params[:email])
        # If yes, is password blank?
        if (params[:password].blank?)
          # If yes, send password reset email and redirect with msg
          # TODO: Set code and expires_at and save user
          # TODO: Send code email
          redirect_to login_url, notice: "A password reset email has been sent."
        else
          # If no, authenticate user
          # TODO: write authenticate method in user model
          if @user.authenticate(params[:email])
            # If authenticated, log in and redirect to /
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
