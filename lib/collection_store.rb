# frozen_string_literal: true

require "date"

# Firestoreのcollectionのラッパークラス
class CollectionStore
  MAX_RETRY_COUNT = 5

  # @param collection_name [String]
  # @param expire_days [Integer] 0より大きければ実行日に加算したタイムスタンプで `expires_at` を設定する
  def initialize(collection_name, expire_days: 0)
    @collection_name = collection_name
    @expire_days = expire_days
  end

  # @param doc_key [String]
  # @return [Hash] documentが見つからなければnilではなく空Hashが返る
  def get(doc_key)
    with_retry("CollectionStore#get") do
      ref = firestore.doc(full_doc_key(doc_key))
      snap = ref.get
      snap&.data || {}
    end
  end

  # @param doc_key [String]
  # @return [Boolean]
  def exists?(doc_key)
    with_retry("CollectionStore#exists?") do
      ref = firestore.doc(full_doc_key(doc_key))
      snap = ref.get
      snap&.exists?
    end
  end

  # @param doc_key [String]
  # @param params [Hash]
  def set(doc_key, params)
    params[:updated_at] ||= Time.now

    if @expire_days > 0
      # NOTE: FirestoreのTTLの仕様上リアルタイムでは消えないので厳密でなくていい
      params[:expires_at] ||= (Date.today + @expire_days)
    end

    ref = firestore.doc(full_doc_key(doc_key))
    ref.set(params)
  end

  # @param doc_key [String]
  # @param params [Hash]
  def update(doc_key, params)
    params[:updated_at] ||= Time.now

    if @expire_days > 0
      # NOTE: FirestoreのTTLの仕様上リアルタイムでは消えないので厳密でなくていい
      params[:expires_at] ||= (Date.today + @expire_days)
    end

    ref = firestore.doc(full_doc_key(doc_key))
    ref.update(params)
  end

  # @param doc_key [String]
  def delete(doc_key)
    ref = firestore.doc(full_doc_key(doc_key))
    ref.delete
  end

  # @param key [String]
  # @return [String]
  def self.sanitize_key(key)
    key&.gsub("/", "-")
  end

  private

  def firestore
    @firestore ||= Google::Cloud::Firestore.new
  end

  def sanitized_collection_name
    sanitize_key(@collection_name)
  end

  def sanitize_key(key)
    CollectionStore.sanitize_key(key)
  end

  def full_doc_key(doc_key)
    "#{sanitized_collection_name}/#{sanitize_key(doc_key)}"
  end

  def with_retry(label) # rubocop:disable Metrics/MethodLength
    yield
  rescue TypeError, GRPC::Unavailable, RuntimeError => e
    if e.instance_of?(RuntimeError) && !e.message.include?("Could not load the default credentials.")
      # RuntimeErrorの時は「Could not load the default credentials. Browse to
      # https://developers.google.com/accounts/docs/application-default-credentials
      # for more information」が起きた時だけリトライさせ、他のエラーの時はエラーにする
      raise e
    end

    retry_count ||= 0
    retry_count += 1

    raise e if retry_count > MAX_RETRY_COUNT

    logger.warn "[#{label}] collection_name=#{@collection_name}, retry_count=#{retry_count}, error=#{e}"
    sleep 1
    retry
  end

  # @return [Logger]
  def logger
    FunctionsFramework.logger
  end
end
