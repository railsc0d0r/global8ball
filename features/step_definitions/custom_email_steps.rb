# coding: utf-8
Dann(/^möchte ich eine Email mit dem Betreff "(.*?)" bekommen haben\.$/) do |subject|
  @player = @player.nil? ? Player.last : @player

  expect(unread_emails_for(@player.email).size).to eql 1

  # this call will store the email and you can access it with current_email
  open_last_email_for(@player.email)
  expect(current_email).to have_subject(subject)

end
