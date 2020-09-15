# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class RatePost < LunaPark::Interactors::Sequence
        attr_accessor :post_id, :rate

        def call!
          raise Errors::PostNotExist unless Domains::Post::Repository.new.exists?(post_id)

          return repo.create(rate_entity) if post_rate.nil?

          DB.transaction do
            post_rate.count += 1
            post_rate.rate = ((rate + post_rate.rate) / post_rate.count).round(2)
            repo.update(post_rate)
          end
        end

        private

        def rate_entity
          @rate_entity ||= Rate::Entity.new(post_id: post_id, rate: rate)
        end

        def repo
          @repo ||= Domains::Rate::Repository.new
        end

        def post_rate
          @post_rate ||= repo.find_by_post_id(post_id)
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
