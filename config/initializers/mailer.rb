require "smtp_tls"
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.smtp_settings = YAML.load_file("#{RAILS_ROOT}/config/mailer.yml")
ActionMailer::Base.smtp_settings[:tsl] = true
ActionMailer::Base.smtp_settings[:authentication] = :login