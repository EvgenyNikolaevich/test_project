# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Serializers
      describe Post do
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

          it { is_expected.to eq expected_response }
        end
      end
    end
  end
end
