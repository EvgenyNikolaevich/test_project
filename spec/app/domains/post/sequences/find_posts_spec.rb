# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe FindPosts do
        let(:post_repo) { Domains::Post::Repository.new }
        let(:rate_repo) { Domains::Rate::Repository.new }

        let(:sequence) { described_class.call!(number: number) }

        describe '.call!' do
          subject(:call!) { sequence }

          context 'when number is not positive' do
            let(:number) { -5 }

            it { expect { call! }.to raise_error(described_class::Errors::NumberNotValid) }
          end

          context 'when find posts' do
            let(:number)  { 3 }

            let!(:posts)  { create_list :post, 5 }
            let!(:rate1)  { create :rate, rate: 3.33, post_id: posts[0].id }
            let!(:rate2)  { create :rate, rate: 1.5, post_id: posts[1].id }
            let!(:rate3)  { create :rate, rate: 4.72, post_id: posts[2].id }
            let!(:rate4)  { create :rate, rate: 4.71, post_id: posts[3].id }

            it { is_expected.to be_an_instance_of Array }

            it { expect(call!).not_to include(posts[1]) }
            it { expect(call!.count).to eq number }
          end

          context 'when does not find posts' do
            let(:number) { 1 }

            it { is_expected.to eq [] }
          end
        end
      end
    end
  end
end
