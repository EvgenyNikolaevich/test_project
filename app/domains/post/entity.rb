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
      # foreign_key author_login for table user
      fk   :author_login, :user, pk: :login
      attr :rate
    end
  end
end
