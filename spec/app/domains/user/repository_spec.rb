# frozen_string_literal: true

require 'spec_helper'

module Domains
  module User
    describe Repository do
      let(:repo) { described_class.new }

      describe '#create' do
        subject { repo.create(input) }

        context 'when given one entity' do
          let(:input) { build :user }

          it 'creates record in database' do
            expect { subject }.to change { DB[:users].count }.by(1)
          end

          it { is_expected.to be_an_instance_of Entity }
        end
      end

      describe '#find_by_login' do
        let(:entity) { build :user }

        subject { repo.find_by_login(entity.login) }

        context 'when user with such login exists' do
          before { repo.create entity }

          it { is_expected.to be_an_instance_of Entity }

          it 'should be correct entity' do
            is_expected.to eq(entity)
          end
        end

        context 'when user does not exist' do
          it { is_expected.to be_nil }
        end
      end

      describe '#find_or_create_by_login' do
        let(:entity) { build :user }

        subject { repo.find_or_create_by_login(entity.login) }

        context 'when user with such login exists' do
          before { repo.create entity }

          it { is_expected.to be_an_instance_of Entity }

          it 'should be correct entity' do
            is_expected.to eq(entity)
          end
        end

        context 'when user does not exist' do
          it 'creates record in database' do
            expect { subject }.to change { DB[:users].count }.by(1)
          end

          it { is_expected.to be_an_instance_of Entity }
        end
      end
    end
  end
end
