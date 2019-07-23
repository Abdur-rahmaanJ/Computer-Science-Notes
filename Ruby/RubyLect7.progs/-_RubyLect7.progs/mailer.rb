# UPDATED FOR CATEGORIES
# MAILER
## Copyright Mark Keane, All Rights Reserved, 2013
require 'active_support'
require 'action_mailer'        

ActionMailer::Base.smtp_settings = {  :address => 'smtp.gmail.com',
                                       :port => 25,
                                       :domain => 'ucd.ie',
                                       :user_name => 'yourname@yourdomain.ie',
                                       :password => 'youraccountpassword',
                                       :authentication  => :plain }
                                       
class SimpleMailer < ActionMailer::Base
	def simple_message(recepient)
		mail(:from => 'yourname@yourdomain.ie',
		     :to => recepient, 
			 :subject => 'tester', 
			 :body => 'wow!, just sent you this from a program')
	end
end

email = SimpleMailer.simple_message('yourname@yourdomain.ie')
puts email
email.deliver



