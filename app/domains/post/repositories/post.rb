# frozen_string_literal: true

module Domains
  module Post
    module Repositories
      class Post < Abstract::Repo
        entity Entities::Post
        mapper Mappers::Post

        private

        def dataset
          DB[:posts]
        end

        alias posts dataset
      end
    end
  end
end
