# frozen_string_literal: true

require_relative "user_token_store"

class TwitterClient
  API_ENDPOINT = "https://api.twitter.com/2"

  # @param [String] user_name
  def initialize(user_name)
    @user_name = user_name
  end

  # @return [Hash]
  def get_me
    with_error_handling do
      simple_twitter_client.get("#{API_ENDPOINT}/users/me")
    end
  end

  # @param [String] text
  def post_tweet(text)
    with_error_handling do
      simple_twitter_client.post("#{API_ENDPOINT}/tweets", json: { text: text })
    end
  end

  private

  # @return [String]
  def access_token
    return @access_token if @access_token

    oauth2 = TwitterOAuth2::Client.new(
      identifier: ENV["TWITTER_V2_CLIENT_ID"],
      secret:     ENV["TWITTER_V2_CLIENT_SECRET"],
    )

    # Get refresh token from Firestore
    oauth2.refresh_token = user_token_store.get_refresh_token

    # Get access tokenn with refresh token
    ret = oauth2.access_token!

    # Save refresh token to Firestore before returning access token
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

  def with_error_handling
    yield
  rescue SimpleTwitter::Error => e
    # NOTE: detail field in response body has been filtered on Sentry...
    FunctionsFramework.logger.error "error=#{e}, response_body=#{e.body}, response_headers=#{e.raw_response.headers.to_h}"

    Sentry.set_extras(
      response_body:    e.body,
      status_code:      e.raw_response.code,
      response_headers: e.raw_response.headers.to_h,
    )
    raise e
  end
end
