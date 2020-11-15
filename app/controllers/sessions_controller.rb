require 'pry'

class SessionsController < ApplicationController 
  def new 
  end

  def create 
    # TODO: check if user credential match
    # redirect to the user's show page if successful
    # else render the /login form with message "PennKey or Password Incorrect"
    @user = User.find_by(pennkey: params[:PennKey])
    if @user.nil?
      redirect_to '/login', notice: "PennKey or Password Incorrect"
    elsif @user.password == params[:Password]
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to '/login', notice: "PennKey or Password Incorrect"
    end
  end
  
  def destroy 
      reset_session
      redirect_to '/login'
  end 

end