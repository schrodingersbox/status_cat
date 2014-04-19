StatusCat.configure do |config|

  config.authenticate_with do
    authenticate! unless Rails.env.test?
  end

  config.authorize_with do
    authorize! unless Rails.env.test?
  end

  config.layout = 'admin'

  config.noreply = 'noreply@schrodingersbox.com'
  config.to = 'ops@schrodingersbox.com'
  config.from = 'ops@schrodingersbox.com'
  config.subject = "#{Rails.env.upcase} StatusCat Failure"
end