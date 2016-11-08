class SessionsController < ApplicationController
  def create
    if user = SlackService.authenticate(params)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in Successfully"
    else
      redirect_to root_path, warning: "Sign in unsuccessful. Please try again."
    end
  end
end