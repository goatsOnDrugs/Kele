require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  attr_accessor :email, :password

  def initialize(email, password)

    options = {
      body: {
        email: email,
        password: password
      }
    }

    response = self.class.post('/sessions', options)
    puts response
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    @user    = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get('/mentors/2345139/student_availability', headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end
end
