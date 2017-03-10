class SpotifyApi

  def search(query)
    binding.pry
  end

  # def authenticate(client_id, client_secret)
  #   @client_id, @client_secret = client_id, client_secret
  #   request_body = { grant_type: 'client_credentials' }
  #   response = RestClient.post(TOKEN_URI, request_body, auth_header)
  #   @client_token = JSON.parse(response)['access_token']
  #   true
  # end

  # scratchpad
  #query = "kanye west"
  #url = "https://api.spotify.com/v1/search?q=#{query}&type=track&limit=20"
  # response = RestClient.send("get", url)
  # stuff = JSON.parse response
  # stuff["tracks"]["items"].first
end
