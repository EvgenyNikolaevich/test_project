# frozen_string_literal: true

module Domains
  module Post
    module Forms
      class CreatePost < LunaPark::Forms::Simple
        validator Validators::CreatePost

        def perform(_valid_params)
          Sequences::CreatePost.call(
            # user_uid: payload[:user_uid],
            # number: number
          )
        end

        private

        def payload
          @payload ||= valid_params.dig(:data, :attributes) || {}
        end

        def number
          Phonelib.parse(payload[:number]).sanitized
        end
      end
    end
  end
end
