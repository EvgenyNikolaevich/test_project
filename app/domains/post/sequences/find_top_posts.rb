# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class FindTopPosts < LunaPark::Interactors::Sequence
        attr_accessor :number

        def call!
          raise Errors::NumberNotValid unless number.to_i.positive?

          Domains::Post::Repository.new.top_rates(number)
        end

        # we can move it in file like errors.rb
        module Errors
          class NumberNotValid < LunaPark::Errors::Processing
            def message
              'Number should be more than 0'
            end
          end
        end
      end
    end
  end
end
