require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:approved_confirmed_trader) }

  describe "#account_approval_email" do
    let(:mail) { described_class.with(user:).account_approval_email.deliver_now }

    it "renders the subject" do
      expect(mail.subject).to eq("Bull Stock Account Approval")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@bullstock.com"])
    end

    it "contains user_session_url in the body" do
      expect(mail.body.encoded).to match("/sign_in")
    end
  end

  describe "#account_deletion_email" do
    let(:mail) { described_class.with(user: user.email).account_deletion_email.deliver_now }

    it "renders the subject" do
      expect(mail.subject).to eq("Bull Stock Account Deletion")
    end

    it "renders the receiver email" do
      expect(mail.to).to(eq([user.email]))
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@bullstock.com"])
    end

    it "contains the email of the user in the body" do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
