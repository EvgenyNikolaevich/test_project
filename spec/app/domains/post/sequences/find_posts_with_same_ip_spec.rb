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
            let(:ip)             { '127.0.0.0' }
            let!(:posts)         { create_list :post, 2, author_ip: ip }
            let!(:post)          { create :post }
            let(:expected_array) { posts.map(&:id) }

            it { is_expected.to be_an_instance_of Hash }

            it { expect(sequence[ip].count).to eq(expected_array.count) }
            it { expect(sequence[ip]).to include(posts.first.author_login) }
          end
        end
      end
    end
  end
end
