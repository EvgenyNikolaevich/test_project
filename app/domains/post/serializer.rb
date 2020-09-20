# frozen_string_literal: true

module Domains
  module Post
    # JSON API serialization
    class Serializer
      include JSONAPI::Serializer

      attribute(:title)
      attribute(:author_login)
      attribute(:article)
      attribute(:author_ip)
      attribute(:rate)

      def type
        :posts
      end

      def id
        object.id.to_s
      end

      def self_link; end
    end
  end
end
