# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'requires an unique, valid email and password' do


    context 'user is invalid' do
      let!(:user) { User.new(email: 'invalid', password: 'short') }

      it 'should fail' do
        expect(user).not_to be_valid
      end
    end

    context 'it rejects duplicates' do
      user = User.new(email: 'valid@example.com', password: 'Password1')
      user.save!
      let!(:duplicate_user) { User.new(email: 'valid@example.com', password: 'Password1') }

      it 'should reject duplicates' do
        expect(duplicate_user).not_to be_valid
      end
    end

    context 'authentication ok' do
      let(:user) { create(:user, password: 'Password1') }

      it 'should authenticate correctly' do
        expect(user.authenticate('Password1')).to be_truthy
        expect(user.authenticate('nope')).to be_falsey
      end
    end
  end
end
