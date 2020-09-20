# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class RatePost < LunaPark::Interactors::Sequence
        attr_accessor :post_id, :rate

        def call!
          raise Errors::PostNotExist unless post

          DB.transaction do
            if post_rate.nil?
              rate_repo.create(rate_entity)
            else
              post_rate.count += 1
              post_rate.rate = ((rate + post_rate.rate) / post_rate.count).round(2)
              rate_repo.update(post_rate)
            end
            post.rate = rate
          end

          post_rate
        end

        private

        def rate_entity
          @rate_entity ||= Rate::Entity.new(post_id: post_id, rate: rate, count: 1)
        end

        def rate_repo
          @rate_repo ||= Domains::Rate::Repository.new
        end

        def post_rate
          @post_rate ||= rate_repo.find_by_post_id(post_id)
        end

        def post
          @post ||= Domains::Post::Repository.new.find(post_id)
        end

        # we can move it in file like errors.rb
        module Errors
          class PostNotExist < LunaPark::Errors::Processing
            def message
              'Post with such id does not exist'
            end
          end
        end
      end
    end
  end
end
