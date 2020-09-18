require 'redmine'

Redmine::Plugin.register :redmine_lock_email_notification_options do
  name 'Redmine Lock Email Notification Options plugin'
  author 'Alex Shulgin <ash@commandprompt.com>'
  description 'Lock user account email notification option at the default setting'
  version '0.2.1'
end

prepare_block = Proc.new do
  User.send(:include, RedmineLockEmailNotificationOptions::UserPatch)
end

if Rails.env.development?
  ((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare { prepare_block.call }
else
  prepare_block.call
end
