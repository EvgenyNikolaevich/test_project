# frozen_string_literal: true

module Domains
  module Post
    module Serializers
      # JSON API serialization
      class AuthorInfo
        include JSONAPI::Serializer

        attribute(:ip)     { object.first }
        attribute(:logins) { object.last }

        def type
          :authors_info
        end

        def id
          object.first
        end

        def self_link; end
      end
    end
  end
end
