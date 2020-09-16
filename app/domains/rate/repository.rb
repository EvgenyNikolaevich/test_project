# frozen_string_literal: true

module Domains
  module Rate
    # work with DB for rates
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

      def find_by_post_id(id)
        read_one rates.where(post_id: id).first
      end

      def update(input)
        entity  = wrap(input)
        row     = to_row(entity)
        new_row = dataset.returning.where(post_id: entity.post_id).update(row).first
        new_attrs = from_row(new_row)
        entity.set_attributes(new_attrs)
        entity
      end

      def top_rates(number)
        read_all rates.reverse_order(:rate).limit(number)
      end

      private

      def dataset
        DB[:rates]
      end

      alias rates dataset
    end
  end
end
