# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class RatePost < LunaPark::Interactors::Sequence
        attr_accessor :post_id, :rate

        def call!
          raise Errors::PostNotExist unless post

          DB.transaction do
            if rate_by_post_id.nil?
              rate_repo.create(new_rate)
            else
              rate_by_post_id.count += 1
              rate_by_post_id.rate = ((rate + rate_by_post_id.rate) / rate_by_post_id.count).round(2)
              rate_repo.update(rate_by_post_id)
            end
            post.rate = rate_by_post_id.rate
            post_repo.update(post)
          end
          post.rate
        end

        private

        def new_rate
          @new_rate ||= Rate::Entity.new(post_id: post_id, rate: rate, count: 1)
        end

        def rate_repo
          @rate_repo ||= Domains::Rate::Repository.new
        end

        def rate_by_post_id
          @rate_by_post_id ||= rate_repo.find_by_post_id(post_id)
        end

        def post_repo
          @post_repo ||= Domains::Post::Repository.new
        end

        def post
          @post ||= post_repo.find(post_id)
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
