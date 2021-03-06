class SpotifyController < ApplicationController
  before_action :get_token, only: :search

  def search
    # organize search q into desired format if more than one word
    search_q = search_text(params)
    # connect to spotify API
    resp = Faraday.get('https://api.spotify.com/v1/search') do |req|
      req.headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': @token
        }
      req.params = {
        'q': search_q,
        'type': params['type'],
        'limit': '10'
      }
    end
    render_result(resp)
  end

  def save_search
    if params[:type] == 'artist'
      if(!Artist.exists?(spotify_id: params[:spotifyID]))
        @result = Artist.create(spotify_id: params[:spotifyID], name: params[:name], spotify_url: params[:spotifyURL])
      end
    else
      if(!Track.exists?(spotify_id: params[:spotifyID]))
        @result = Track.create(spotify_id: params[:spotifyID], name: params[:name], spotify_url: params[:spotifyURL])
      end
    end
    render plain: 'OK'
  end

  private

  def search_text(params)
    if params['q'].split(' ').length > 1
      search_q = params['q'].split(' ').join('+')
    elsif params['q'].blank?
      render status: 400, json: {error: 'expected parameter q'}
    else
      search_q = params['q']
    end
  end

  def render_result(resp)
    if resp.success?
      @result = JSON.parse(resp.body)
      render status: 200, json: @result
    else
      @result = resp['body']
      render status: 400, json: @result
    end
  end


end
