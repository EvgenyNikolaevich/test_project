# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class FindPostsWithSameIp < LunaPark::Interactors::Sequence
        def call!
          Domains::Post::Repository.new.from_same_ip
        end
      end
    end
  end
end
