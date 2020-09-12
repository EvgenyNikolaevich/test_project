# frozen_string_literal: true

module Domains
  module Post
    module Sequences
      describe CreatePost do
        let(:sequence) do
          described_class.new
        end

        before do
          allow(Email).to receive(:orders_repo).and_return(stubbed_orders_repo)
          allow(Email).to receive(:identities_repo).and_return(stubbed_identities_repo)

          allow(stubbed_orders_repo).to     receive(:exists_by_user_uid?).with(user.uid).and_return(order_existence_by_user_uid)
          allow(stubbed_identities_repo).to receive(:exists_by_user_uid?).with(user.uid).and_return(identity_existence_by_user_uid)
          allow(stubbed_identities_repo).to receive(:exists?).with(user.email).and_return(identity_existence_by_email)

          allow(stubbed_orders_repo).to receive(:create)
        end

        describe '.call!' do
          let(:mail_adapter) { instance_double Adapters::Mail, send_creating_confirmation_link: true }
          let(:token)        { generate :email_code }

          let(:order_existence_by_user_uid)    { false }
          let(:identity_existence_by_user_uid) { false }
          let(:identity_existence_by_email)    { false }

          subject(:call!) { sequence.call! }

          before do
            allow(Email).to receive(:mail_adapter).and_return(mail_adapter)
            allow(Email::Services::GenerateToken).to receive(:call).and_return(token)
          end

          context 'when all guards pass,' do
            it { is_expected.to be_an_instance_of Email::Order }

            it 'created order has new data' do
              expect(call!.user_uid).to           eq user.uid
              expect(call!.email).to              eq user.email
              expect(call!.expired_at).to         eq expired_at
              expect(call!.confirmation_token).to eq token
            end
          end

          context 'when order already exists for user,' do
            let(:order_existence_by_user_uid) { true }

            it { expect { call! }.to raise_error errors::UserHasOrder }
          end

          context 'when user has confirmed email,' do
            let(:identity_existence_by_user_uid) { true }

            it { expect { call! }.to raise_error errors::UserHasIdentity }
          end

          context 'when such an email is already taken,' do
            let(:identity_existence_by_email) { true }

            it { expect { call! }.to raise_error errors::EmailInUse }
          end
        end
      end
    end
  end
end
