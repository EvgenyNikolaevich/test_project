# frozen_string_literal: true

module Domains
  module Post
    module Validators
      class CreatePost < LunaPark::Validators::Dry
        IP_PATTERN = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.freeze
        private_constant :IP_PATTERN

        validation_schema do
          params do
            required(:data).hash do
              optional(:type) { eql? 'posts' }
              required(:attributes).hash do
                required(:title)   { str? && filled? }
                required(:article) { str? && filled? }
                # according to technical requirement they are not required
                optional(:login)   { str? }
                optional(:ip).filled(:string, format?: IP_PATTERN)
              end
            end
          end
        end
      end
    end
  end
end
