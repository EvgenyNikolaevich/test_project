# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class CreatePost < LunaPark::Interactors::Sequence
        attr_accessor :title, :article, :login, :ip

        def call!
          # for some business conditions we can add here some errors like:
          # raise Errors::TitleNotUnique if Post.repo.find_by_login(login)

          DB.transaction do
            # TODO: передавать объект
            Domains::User.repo.create(login, ip) unless user
            Domains::Post.repo.create(title, article)
          end

          post
        end

        private

        def user
          @user ||= Domains::User.repo.find_by_login(login)
        end
      end
    end
  end
end
