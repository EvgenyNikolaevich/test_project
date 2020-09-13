# frozen_string_literal: true

module Domains
  module User
    # entity for User-object
    class Entity < LunaPark::Entities::Attributable
      extend LunaPark::Extensions::Dsl::ForeignKey

      attr :id
      attr :login
    end
  end
end
