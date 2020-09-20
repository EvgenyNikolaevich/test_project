# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Post
    describe Repository do
      let(:repo) { described_class.new }

      describe '#create' do
        subject { repo.create(input) }

        context 'when given one entity' do
          let(:input) { build :post }

          it 'creates record in database' do
            expect { subject }.to change { DB[:posts].count }.by(1)
          end

          it { is_expected.to be_an_instance_of Entity }
        end
      end

      describe '#find' do
        let(:entity) { build :post }

        subject { repo.find(entity.id) }

        context 'when post exists' do
          before { repo.create entity }

          it { is_expected.to be_an_instance_of Entity }

          it 'should be correct entity' do
            is_expected.to eq(entity)
          end
        end

        context 'when post does not exist' do
          it { is_expected.to be_nil }
        end
      end

      describe '#top_rates' do
        let(:number) { 3 }

        subject { repo.top_rates(number) }

        context 'when find posts with top rates' do
          let!(:post1)  { create :post, rate: 3.33 }
          let!(:post2)  { create :post, rate: 1.5 }
          let!(:post3)  { create :post, rate: 4.72 }
          let!(:post4)  { create :post, rate: 4.71 }

          it { is_expected.to be_an_instance_of Array }

          it 'returns the top' do
            expect(subject).not_to include(post2)
            expect(subject.count).to eq(number)
          end
        end

        context 'when does not find any rates' do
          it { is_expected.to eq [] }
        end
      end

      describe '#from_same_ip' do
        subject { repo.from_same_ip }

        context 'when find posts successfully' do
          let!(:posts)          { create_list :post, 2, author_ip: '127.0.0.0' }
          let!(:post)           { create :post }
          let(:expected_number) { 2 }

          let(:expected_response) do
            {
              author_ip: posts.first.author_ip,
              author_login: posts.first.author_login
            }
          end

          it { expect(subject.count).to eq(expected_number) }
          it { expect(subject.first).to include(expected_response) }
        end

        context 'post does not exist' do
          let(:expected_number) { 0 }

          it { expect(subject.count).to eq(expected_number) }
        end
      end
    end
  end
end
