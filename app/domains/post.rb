# frozen_string_literal: true

module Domains
  module Post
    class << self
      # Repository of post
      # @return [Repositories::Post]
      def repo
        @repo ||= Repositories::Post.new
      end
    end
  end
end
