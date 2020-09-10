# frozen_string_literal: true

module Domains
  module User
    class Repository < Abstract::Repo
      entity Entity
      mapper Mapper

      private

      def dataset
        DB[:users]
      end

      alias users dataset
    end
  end
end
