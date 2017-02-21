class MirrorsController < ApplicationController
  
  def new
    @mirror = Mirror.new
  end

  def index
    @mirrors = remote.get('mirrors')
  end

  def create
    p mirror_params.to_json
    Mirror.create(mirror_params, session['token'])
  end

  private

  def remote
    @remote ||= Mirrorhub::API::Client.new('localhost:8080/v1', token: session['token'])
  end

  def mirror_params
    params.require(:mirror).permit(:contact_id, :name, :domain, :bandwidth,
                                   :available_storage, :traffic, :service_id,
                                   :endpoint_id, :local_destination)
  end
end
