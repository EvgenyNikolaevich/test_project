# frozen_string_literal: true

module Domains
  module Post
    module Validators
      class RatePost < LunaPark::Validators::Dry
        RATE_RANGE = (1..5).freeze
        private_constant :RATE_RANGE

        validation_schema do
          params do
            required(:data).hash do
              optional(:type) { eql? 'rate_post' }
              required(:attributes).hash do
                required(:post_id) { int? && filled? }
                required(:rate).filled(:integer, included_in?: RATE_RANGE)
              end
            end
          end
        end
      end
    end
  end
end
