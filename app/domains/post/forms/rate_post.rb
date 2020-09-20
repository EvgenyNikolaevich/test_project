# frozen_string_literal: true

module Domains
  module Post
    module Forms
      class RatePost < LunaPark::Forms::Simple
        validator Validators::RatePost

        def perform(_valid_params)
          Sequences::RatePost.call(
            post_id: post_id,
            rate: rate
          )
        end

        private

        def post_id
          attributes.dig(:post_id)
        end

        def rate
          attributes.dig(:rate)
        end

        def attributes
          @attributes ||= valid_params.dig(:data, :attributes) || {}
        end
      end
    end
  end
end
