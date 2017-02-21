class Mirror

  attr_accessor :name, :domain, :traffic, :bandwidth, :service_id,
                :available_storage, :endpoint_id, :local_destination
  def initialize
  end
  
  def self.create(params, token)
    r = self.remote(token)
    r.post('mirrors', body: params)
  end

  private

  def self.remote(token)
    @remote ||= Mirrorhub::API::Client.new('localhost:8080/v1', token: token)
  end
end
