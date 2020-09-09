# frozen_string_literal: true

module Domains
  module Post
    module Entities
      # entity for Post-object
      class Post < LunaPark::Entities::Attributable
        extend LunaPark::Extensions::Dsl::ForeignKey

        attr :id
        attr :title
        attr :article
        # foreign_key user_id for table user
        fk   :user_id, :user, pk: :id

        attr :created_at
        attr :updated_at
      end
    end
  end
end
