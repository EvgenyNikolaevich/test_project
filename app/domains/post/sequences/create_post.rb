# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      class CreatePost < LunaPark::Interactors::Sequence
        attr_accessor :title, :article, :login, :ip

        def call!
          # for some business conditions we can add here some errors like:
          # raise Errors::TitleNotUnique if Post.repo.find_by_login(login)

          post              = Entity.new
          post.title        = title
          post.article      = article
          post.author_ip    = ip
          post.author_login = user.login

          Domains::Post::Repository.new.create(post)

          post
        end

        private

        def user
          @user ||= Domains::User::Repository.new.find_or_create_by_login(login)
        end
      end
    end
  end
end
