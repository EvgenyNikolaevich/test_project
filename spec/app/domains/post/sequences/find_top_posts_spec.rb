# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe FindTopPosts do
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

            let!(:post1)  { create :post, rate: 3.33 }
            let!(:post2)  { create :post, rate: 1.5 }
            let!(:post3)  { create :post, rate: 4.72 }
            let!(:post4)  { create :post, rate: 4.71 }

            it { is_expected.to be_an_instance_of Array }

            it { expect(call!).not_to include(post2) }
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
