require 'rails_helper'

RSpec.describe UserNotificationMailer, type: :mailer do
  describe ".missed_learning_event" do
    let!(:user) { create(:user) }

    let(:mail) do
      described_class.with(user:).missed_learning_event
    end

    it "renders appropriate subject" do
      expect(mail.subject).to eq('Reminder of learning event!')
    end

    it "assigns appropriate email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders body content" do
      expect(mail.body.to_s).to include(user.email)
    end
  end
end