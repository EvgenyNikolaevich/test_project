# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe RatePost do
        let!(:post)   { create :post, id: post_id }
        let(:post_id) { 6 }

        let(:sequence) do
          described_class.call!(
            post_id: post_id,
            rate: 5
          )
        end

        describe '.call!' do
          subject(:call!) { sequence }

          context 'when post with such id does not exist' do
            let(:post) {}

            it { expect { call! }.to raise_error(described_class::Errors::PostNotExist) }
          end

          context 'when rate does not exist' do
            let(:expected_rate)  { 5 }
            let(:expected_count) { 1 }

            it { expect(call!.rate).to eq expected_rate }
            it { expect(call!.count).to eq expected_count }
          end

          context 'when rate has already existed' do
            let(:expected_rate)  { 1.33 }
            let(:expected_count) { 6 }
            let!(:rate)          { create :rate, rate: 3, count: 5, post_id: post_id }

            it { expect(call!.rate).to eq expected_rate }
            it { expect(call!.count).to eq expected_count }
          end
        end
      end
    end
  end
end
