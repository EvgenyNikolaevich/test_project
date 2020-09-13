# frozen_string_literal: true

module Domains
  module Post
    # work with DB for posts
    class Repository < LunaPark::Repositories::Sequel
      entity Entity
      mapper Mapper

      def create(input)
        entity    = wrap(input)
        row       = to_row(entity)
        new_row   = dataset.returning.insert(row).first
        new_attrs = from_row(new_row)
        entity.set_attributes(new_attrs)
        entity
      end

      def find(id)
        read_one posts.where(id: id).first
      end

      def exists?(id)
        !dataset.where(id: id).empty?
      end

      private

      def dataset
        DB[:posts]
      end

      alias posts dataset
    end
  end
end
