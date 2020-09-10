# frozen_string_literal: true

module Domains
  module Post
    module Mappers
      class Post < LunaPark::Mappers::Simple
        KEYS = %i[
          id user_id
          title article
          author_ip
        ].freeze

        class << self
          def from_row(row)
            row.to_h
          end

          def to_row(input)
            input.to_h.slice(*KEYS)
          end
        end
      end
    end
  end
end
