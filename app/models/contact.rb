class Contact
  attr_reader :token
  def initialize(token: nil)
    @token = token
  end

  def auth(email, password)
    res = remote.post('contacts/auth',
                       body: {email: email,
                              password: password})

   true if @token = res['token']
  end

  def email
  end

  def name
  end

  def password
  end

  def register(email, password, name)
    res = remote.post('contacts', body: {name: name,
                                   email: email,
                                   password: password})
    true if @token = res['token']
  end


  private

  def remote
    @remote ||= Mirrorhub::API::Client.new('localhost:8080/v1')
  end

end
