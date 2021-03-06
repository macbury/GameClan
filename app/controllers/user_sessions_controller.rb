class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Zostałeś zalogowany w serwisie"
      redirect_back_or_default
    else
      flash[:error] = "Nieprawidłowe hasło lub login"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Zostałeś wylogowany"
    redirect_to root_url
  end
end
