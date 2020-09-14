# frozen_string_literal: true

module Domains
  module Rate
    # entity for Rate-object
    class Entity < LunaPark::Entities::Attributable
      attr :rate
      attr :post_id
      attr :count
    end
  end
end
