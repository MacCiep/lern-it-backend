# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject(:user_validation) { user.valid? }

    shared_examples 'invalidates the user record' do
      it { expect(user_validation).to be(false) }
    end

    context 'with email validation' do
      context "when user's email is nil" do
        let(:user) { build(:user, email: nil) }

        it_behaves_like 'invalidates the user record'
      end

      context "when user's email is in the wrong format" do
        let(:user) { build(:user, email: 'test.com') }

        it_behaves_like 'invalidates the user record'
      end
    end

    context 'with password validation' do
      context "when user's password is nil" do
        let(:user) { build(:user, password: nil) }

        it_behaves_like 'invalidates the user record'
      end

      context "when user's password is too short" do
        let(:user) { build(:user, password: 'test') }

        it_behaves_like 'invalidates the user record'
      end
    end
  end
end
