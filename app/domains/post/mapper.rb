# frozen_string_literal: true

module Domains
  module Post
    class Mapper < LunaPark::Mappers::Simple
      KEYS = %i[
          id author_login
          title article
          author_ip
          rate
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
