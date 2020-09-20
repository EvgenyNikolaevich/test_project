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
