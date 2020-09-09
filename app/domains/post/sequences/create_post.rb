# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class CreatePost < LunaPark::Interactors::Sequence
        attr_accessor :title, :article, :login, :ip

        def call!
          # for some business conditions we can add here some errors like:
          # raise Errors::TitleNotUnique if Post.repo.find_by_login(login)

          post         = Entities::Post.new
          post.title   = title
          post.article = article
          post.ip      = ip
          post.user_id = user.id

          DB.transaction do
            # TODO: порефакторить бы
            Domains::User.repo.create(login, ip) unless user
            Domains::Post.repo.create(post)
          end

          post
        end

        private

        def user
          @user ||= Domains::User.repo.find_or_create_by_login(login)
        end
      end
    end
  end
end
