require "test_helper"

class SupportRequestMailerTest < ActionMailer::TestCase
  test "respond" do
    support_request = SupportRequest.new(
      email: "customer@example.com",
      subject: "Need help",
      body: "I need help with my order"
    )
    support_request.response = "Here is the answer to your question."

    mail = SupportRequestMailer.respond(support_request)

    assert_equal ["customer@example.com"], mail.to
    assert_equal "Re: Need help", mail.subject
    assert_equal ["support@example.com"], mail.from
  end
end