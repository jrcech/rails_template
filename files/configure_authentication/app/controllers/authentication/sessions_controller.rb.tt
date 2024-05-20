module Authentication
  class SessionsController < ApplicationController
    before_action :enable_honeypot, only: :create

    def new; end

    def create
      if (user = User.authenticate_by(email: params[:email], password: params[:password]))
        login user

        redirect_to root_url, success: 'Signed in'
      else
        flash[:danger] = 'Incorrect email or password'

        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      logout

      redirect_to root_url, info: 'Signed out'
    end
  end
end
