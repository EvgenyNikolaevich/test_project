# frozen_string_literal: true

module Domains
  module User
    class Repository < LunaPark::Repositories::Sequel
      entity Entity
      mapper Mapper

      def find_or_create_by_login(login)
        find_by_login(login) || create(login)
      end

      def find_by_login(login)
        read_one users.where(login: login)
      end

      def create(input)
        entity    = wrap(input)
        row       = to_row(entity)
        new_row   = dataset.returning.insert(row).first
        new_attrs = from_row(new_row)
        entity.set_attributes(new_attrs)
        entity
      end

      private

      def dataset
        DB[:users]
      end

      alias users dataset
    end
  end
end
