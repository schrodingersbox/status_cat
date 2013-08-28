StatusCat.configure do |config|
  config.noreply = 'noreply@schrodingersbox.com'
  config.to = 'ops@schrodingersbox.com'
  config.from = 'ops@schrodingersbox.com'
  config.subject = "#{Rails.env.upcase} StatusCat Failure"
end