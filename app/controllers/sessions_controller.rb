class SessionsController < ApplicationController

  # skip before authenticating for new and create, otherwise you will get into a redirect loop
  # since we put the authenticate user in application_controller, every page will require
  # authentication unless you explicitly skip it.
  skip_before_filter :authenticate_user, only: [:new, :create]

  # show login form
  def new
  end

  # login
  def create
    # store the userid in the session, then you can access the same user in the future
    # session[:user_id]    

    # just look at the params
    # render :text => params.inspect
    
    #     if session[:user_id] = authenticated_user_id
    #       # go back to the home page, this user is authenticated
    #       redirect_to root_path
    #     else
    #       # something is wrong, render this login form again
    #       render 'new'
    #     end

    #     session[:user_id] = authenticated_user_id
    #     redirect_to root_path
    #   rescue
    #     # need to add if flash[:alert].present? to the application.html.erb
    #     flash[:alert] = "Email or password incorrect"
    #     redirect_to new_session_path # render "new" does not get rid of previous alert

    if session[:user_id] = authenticated_user_id
      redirect_to root_path
    else
      flash[:alert] = "Email or password incorrect"
      redirect_to new_session_path
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def authenticated_user_id
    user_from_email.id  
  end

  def user_from_email
    # tap calls the block and returns the same object, sets up additional context
    #User.find_by_email(params[:email]).tap do |user|
    #  raise AuthenticationError.new("Password not valid") unless user.verify_password(params[:password])
    #end

    #(User.find_by_email(params[:email]) || NullObject.new).tap do |user|
    #  return NullObject.new unless user.verify_password(params[:password])
    #end

    user_or_null.tap do |user|
      return NullObject.new unless user.verify_password(params[:password])
    end
  end

  def user_or_null
    User.find_by_email(params[:email]) || NullObject.new
  end
end

class AuthenticationError < StandardError
end