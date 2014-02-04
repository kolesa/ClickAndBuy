require 'test_helper'

class ModelMailerTest < ActionMailer::TestCase
  test "user_add_notification" do
    mail = ModelMailer.user_add_notification
    assert_equal "User add notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
