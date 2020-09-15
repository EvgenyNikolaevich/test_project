# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe CreatePost do
        let(:post) { build :post }
        let(:sequence) do
          described_class.call!(
            title: post.title,
            article: post.article,
            login: user.login,
            ip: post.author_ip
          )
        end


        describe '.call!' do
          let(:user) { build :user }

          before { allow_any_instance_of(User::Repository).to receive(:find_or_create_by_login).and_return(user) }

          subject(:call!) { sequence }

          context 'when post is created successfully' do
            it 'created post has data' do
              expect(call!.title).to eq post.title
              expect(call!.article).to eq post.article
              expect(call!.author_ip).to eq post.author_ip
              expect(call!.author_login).to eq user.login
            end
          end
        end
      end
    end
  end
end
