# frozen_string_literal: true

require_relative "user_token_store"

class TwitterClient
  API_ENDPOINT = "https://api.twitter.com/2"

  class Error < StandardError
  end

  # @param [String] user_name
  def initialize(user_name)
    @user_name = user_name
  end

  # @return [Hash]
  def get_me
    get("#{API_ENDPOINT}/users/me")
  end

  # @param [String] text
  def post_tweet(text)
    post_with_json("#{API_ENDPOINT}/tweets", text: text)
  end

  private

  # @return [String]
  def access_token
    return @access_token if @access_token

    oauth2 = TwitterOAuth2::Client.new(
      identifier: ENV["TWITTER_V2_CLIENT_ID"],
      secret:     ENV["TWITTER_V2_CLIENT_SECRET"],
    )

    oauth2.refresh_token = user_token_store.get_refresh_token

    ret = oauth2.access_token!

    user_token_store.set_refresh_token(ret.refresh_token)

    @access_token = ret.access_token
  end

  # @return [UserTokenStore]
  def user_token_store
    @user_token_store ||= UserTokenStore.new(@user_name)
  end

  # @return [SimpleTwitter::Client]
  def simple_twitter_client
    @simple_twitter_client ||= SimpleTwitter::Client.new(bearer_token: access_token)
  end

  # @param url [String]
  # @param params [Hash]
  def get(url, params = {})
    simple_twitter_client.get(url, params)
  end

  # @param url [String]
  # @param params [Hash]
  def post(url, params = {})
    simple_twitter_client.post(url, params)
  end

  # @param url [String]
  # @param params [Hash]
  def post_with_json(url, params = {})
    simple_twitter_client.post(url, {}, params)
  end
end
