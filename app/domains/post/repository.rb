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
        new_row   = posts.returning.insert(row).first
        new_attrs = from_row(new_row)
        entity.set_attributes(new_attrs)
        entity
      end

      def find(id)
        read_one posts.where(id: id).first
      end

      def exists?(id)
        !posts.where(id: id).empty?
      end

      def find_by_ids(ids)
        read_all posts.where(id: ids)
      end

      def from_same_ip
        author_ips = 'SELECT author_ip FROM posts GROUP BY 1 HAVING COUNT(author_ip) > 1'
        read_all posts.where(Sequel.lit("author_ip IN (#{author_ips})"))
      end

      private

      def dataset
        DB[:posts]
      end

      alias posts dataset
    end
  end
end
