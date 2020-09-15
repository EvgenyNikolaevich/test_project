# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe RatePost do
        let(:post_repo) { Domains::Post::Repository.new }
        let(:post)      { build :post, id: post_id }
        let(:post_id)   { 6 }

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

            it { expect { call! }.to raise_error(described_class::Errors::PostNotExist) }
          end

          context 'when rate does not exist' do
            let(:expected_rate)  { 5 }
            let(:expected_count) { 1 }

            before { post_repo.create(post) }

            it { expect(call!.data.rate).to eq expected_rate }
            it { expect(call!.data.count).to eq expected_count }
          end

          context 'when rate has already existed' do
            let(:expected_rate)  { 1.33 }
            let(:expected_count) { 6 }
            let(:rate_repo)      { Domains::Rate::Repository.new }
            let(:rate)           { build :rate, rate: 3, count: 5, post_id: post_id }

            before do
              post_repo.create(post)
              rate_repo.create(rate)
            end

            it { expect(call!.data.rate).to eq expected_rate }
            it { expect(call!.data.count).to eq expected_count }
          end
        end
      end
    end
  end
end
