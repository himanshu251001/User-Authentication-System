class DeviseMailer < Devise::Mailer
    include Devise::Controllers::UrlHelpers
    default template_path: 'devise/mailer'
  
    # Send emails asynchronously
    def confirmation_instructions(record, token, opts = {})
      opts[:async] = true # Custom option (not used by Devise directly)
      DeviseMailerJob.perform_later(record, token, opts) # Enqueue email job
    end
  end
  