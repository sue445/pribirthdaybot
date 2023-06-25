# frozen_string_literal: true

require_relative "collection_store"

class UserTokenStore
  # @param user_name [String]
  def initialize(user_name)
    @user_name = user_name
  end

  # @return [String]
  def get_refresh_token
    ret = store.get(@user_name)
    ret[:refresh_token]
  end

  # @param [String]
  def set_refresh_token(refresh_token)
    store.set(@user_name, refresh_token: refresh_token)
  end

  private

  # @return [CollectionStore]
  def store
    @store ||= CollectionStore.new("user_token")
  end
end
