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

        context 'post exists' do
          before { repo.create entity }

          it { is_expected.to be_an_instance_of Entity }

          it 'should be correct entity' do
            is_expected.to eq(entity)
          end
        end

        context 'post does not exist' do
          it { is_expected.to be_nil }
        end
      end

      describe '#exists?' do
        let(:entity) { build :post }

        subject { repo.exists?(entity.id) }

        context 'post with id already exists' do
          before { repo.create entity }

          it { is_expected.to eq true }
        end

        context 'post with id does not exists' do
          it { is_expected.to eq false }
        end
      end
    end
  end
end
