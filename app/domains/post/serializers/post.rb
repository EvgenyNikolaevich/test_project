# frozen_string_literal: true

module Domains
  module Post
    module Serializers
      # JSON API serialization
      class Post
        include JSONAPI::Serializer

        attributes(:title, :author_login, :article, :author_ip, :rate)

        def type
          :posts
        end

        def id
          object.id.to_s
        end

        def self_link; end

        def format_name(attribute_name)
          attribute_name.to_s
        end
      end
    end
  end
end
