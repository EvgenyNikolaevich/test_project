# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    module Sequences
      describe FindPostsWithSameIp do
        let(:post_repo) { Domains::Post::Repository.new }

        let(:sequence) { described_class.call! }

        describe '.call!' do
          subject(:call!) { sequence }

          context 'when find posts successfully' do
            let!(:posts)         { create_list :post, 2, author_ip: '127.0.0.0' }
            let!(:post)          { create :post }
            let(:expected_array) { posts.map(&:id) }

            it { is_expected.to be_an_instance_of Array }

            it { expect(sequence.count).to eq(expected_array.count) }
            it { expect(sequence).to include(posts.first) }
            it { expect(sequence).to include(posts[1]) }
          end
        end
      end
    end
  end
end
