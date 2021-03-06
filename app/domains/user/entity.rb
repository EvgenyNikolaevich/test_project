# frozen_string_literal: true

module Domains
  module User
    # entity for User-object
    class Entity < LunaPark::Entities::Attributable
      attr :id
      attr :login
    end
  end
end
