class ContactController < ApplicationController

  before_action :set_contact

  def login
    redirect_to root_path if session['token']
  end
  def register
    redirect_to root_path if session['token']
  end

  def signin
    params = contact_params
    @contact.auth(params['email'], params['password'])
    if session['token'] = @contact.token
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def logout
    session['token'] = nil
    redirect_to :back
  end

  def signup
    params = contact_params
    @contact.register(params['email'],
                      params['password'],
                      params['name'])
    if session['token'] = @contact.token
      redirect_to root_path
    else
      redirect_to :back
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :password)
  end

  def set_contact
    @contact = Contact.new(token: session['token'])
  end
end
