# frozen_string_literal: true

require 'spec_helper'

module Domains
  module Rate
    describe Repository do
      let(:repo) { described_class.new }

      describe '#create' do
        subject { repo.create(input) }

        context 'when given one entity' do
          let(:input) { build :rate }

          it 'creates record in database' do
            expect { subject }.to change { DB[:rates].count }.by(1)
          end

          it { is_expected.to be_an_instance_of Entity }
        end
      end

      describe '#find_by_post_id' do
        let(:entity) { build :rate, post_id: 1 }

        subject { repo.find_by_post_id(entity.post_id) }

        context 'when rate exists' do
          before { repo.create entity }

          it { is_expected.to be_an_instance_of Entity }
          it { is_expected.to eq entity }
        end

        context 'when rate does not exist' do
          it { is_expected.to be_nil }
        end
      end

      describe '#top_rates' do
        let(:number) { 3 }

        subject { repo.top_rates(number) }

        context 'when find rates' do
          let!(:rate1)  { create :rate, rate: 3.33 }
          let!(:rate2)  { create :rate, rate: 1.5 }
          let!(:rate3)  { create :rate, rate: 4.72 }
          let!(:rate4)  { create :rate, rate: 4.71 }

          it { is_expected.to be_an_instance_of Array }

          it 'returns the top' do
            expect(subject).not_to include(rate2)
            expect(subject.count).to eq number
          end
        end

        context 'when does not find any rates' do
          it { is_expected.to eq [] }
        end
      end

      describe '#update' do
        let(:updated_entity) { build :rate, post_id: 1, count: 5, rate: 100 }

        subject { repo.update(updated_entity) }

        context 'when successfully updated' do
          let(:old_entity) { build :rate, post_id: 1 }

          before { repo.create old_entity }

          it { is_expected.to be_an_instance_of Entity }
          it { is_expected.to eq updated_entity }
        end
      end
    end
  end
end
