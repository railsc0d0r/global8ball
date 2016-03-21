class MyMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    opts[:from] = 'noreply@global8ball.com'
    opts[:reply_to] = 'contact@global8ball.com'
    super
  end

  def reset_password_instructions(record, token, opts={})
    opts[:from] = 'noreply@global8ball.com'
    opts[:reply_to] = 'contact@global8ball.com'
    super
  end

  def unlock_instructions(record, token, opts={})
    opts[:from] = 'noreply@global8ball.com'
    opts[:reply_to] = 'contact@global8ball.com'
    super
  end

end
