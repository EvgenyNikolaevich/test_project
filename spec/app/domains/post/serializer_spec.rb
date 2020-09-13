# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    describe Serializer do
      describe '.serialize' do
        let(:entity) { build :post, id: 1 }
        let(:expected_response) do
          {
            'data' => {
              'id' => entity.id.to_s,
              'type' => 'posts',
              'attributes' => {
                'title' => entity.title,
                'article' => entity.article,
                'author_login' => entity.author_login,
                'author_ip' => entity.author_ip
              }
            }
          }
        end

        subject { described_class.serialize entity }

        it 'should be eq correct hash' do
          expect(subject).to eq(expected_response)
        end
      end
    end
  end
end
