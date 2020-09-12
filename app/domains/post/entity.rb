# frozen_string_literal: true

module Domains
  module Post
    # entity for Post-object
    class Entity < LunaPark::Entities::Attributable
      extend LunaPark::Extensions::Dsl::ForeignKey

      attr :id
      attr :title
      attr :article
      attr :author_ip
      # foreign_key user_id for table user
      fk   :user_id, :user, pk: :id
    end
  end
end
