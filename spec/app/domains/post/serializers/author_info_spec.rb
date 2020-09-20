# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Serializers
      describe AuthorInfo do
        describe '.serialize' do
          let(:entity) { create_list :post, 5 }
          let(:data)   do
            {
              entity.first.author_ip.to_s => entity.map(&:author_login)
            }
          end

          let(:expected_response) do
            {
              'data' => [{
                'id' => entity.first.author_ip,
                'type' => 'authors_info',
                'attributes' => {
                  'ip' => entity.first.author_ip,
                  'logins' => entity.map(&:author_login)
                }
              }]
            }
          end

          subject { described_class.serialize(data, is_collection: true) }

          it { is_expected.to eq expected_response }
        end
      end
    end
  end
end
