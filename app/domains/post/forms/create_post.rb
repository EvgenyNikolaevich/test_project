# frozen_string_literal: true

module Domains
  module Post
    module Forms
      class CreatePost < LunaPark::Forms::Simple
        validator Validators::CreatePost

        def perform(_valid_params)
          Sequences::CreatePost.call(
            title: title,
            article: article,
            login: login,
            ip: ip
          )
        end

        private

        def title
          attributes.dig(:title)
        end

        def article
          attributes.dig(:article)
        end

        def login
          attributes.dig(:login)
        end

        def ip
          attributes.dig(:ip)
        end

        def attributes
          @attributes ||= valid_params.dig(:data, :attributes) || {}
        end
      end
    end
  end
end
