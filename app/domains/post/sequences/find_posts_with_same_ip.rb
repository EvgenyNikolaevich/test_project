# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class FindPostsWithSameIp < LunaPark::Interactors::Sequence
        def call!
          posts = Domains::Post::Repository.new.from_same_ip.to_a

          posts.each_with_object({}) do |item, result|
            ip = item[:author_ip]

            result[ip] = [] unless result.key?(ip)
            result[ip] << item[:author_login]
          end
        end
      end
    end
  end
end
