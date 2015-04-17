class SessionsController < ApplicationController
  skip_before_action :ensure_login,
    only: [:new, :create, :destroy]

  def new
  end

  def create
    name = params[:reviewer][:name]
    password = params[:reviewer][:password]

    reviewer = Reviewer.find_by name: name
    if(reviewer && reviewer.authenticate(password))
      session[:reviewer_id] = reviewer.id
      redirect_to root_path, notice: "Logged in successfully..."
    else
      flash.now[:alert] = "Invalid username/password combination!"
      render action: "new"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "You have been logged out."
  end
end