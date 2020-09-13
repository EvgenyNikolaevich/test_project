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

      def type
        :posts
      end

      def id
        object.id.to_s
      end

      def self_link; end

      # TODO: need?
      def format_name(attribute_name)
        attribute_name.to_s
      end
    end
  end
end
