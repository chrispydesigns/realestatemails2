class FlyerDecorator < BaseDecorator
  include PageParts
 
  def email_message
    message_params = { 
      from: 'Mailgun Sandbox <postmaster@sandbox5174d49fc72642e7831b266b19a0cbd4.mailgun.org>',
      to: 'reetest@sandbox5174d49fc72642e7831b266b19a0cbd4.mailgun.orgx',
      subject: 'Test property',
      text: "Test message",
      html: content
    }
  end

end
