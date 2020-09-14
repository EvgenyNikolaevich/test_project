# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe RatePost do
        let(:post)    { build :post, id: post_id }
        let(:post_id) { 6 }
        let(:sequence) do
          described_class.call(
            post_id: post_id,
            rate: 5
          )
        end

        describe '.call!' do
          subject(:call!) { sequence }

          context 'when post with such id does not exist' do
            let(:post) {}

            it { expect { call! }.to raise_error described_class::Errors::PostNotExist }
          end

          context 'when rate is created successfully' do
            let(:expected_avg) { 1.4 }

            before { create_list :rate, 9, post_id: post.id }

            it 'return average rate of post' do
              expect(call!.data).to eq expected_avg
            end
          end
        end
      end
    end
  end
end
