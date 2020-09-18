module RedmineLockEmailNotificationOptions
  module UserPatch
    unloadable

    def self.included(base)
      base.class_eval do
        extend ClassMethods
        class << self
          alias_method :valid_notification_options_without_lock, :valid_notification_options
          alias_method :valid_notification_options, :valid_notification_options_with_lock
        end
      end
    end

    module ClassMethods
      def valid_notification_options_with_lock(user=nil)
        valid_notification_options_without_lock(user).tap do |options|
          options.reject! {|o| o.first != Setting.default_notification_option} unless User.current.admin?
        end
      end
    end
  end
end
