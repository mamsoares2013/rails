module ActionController
  module HideActions
    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
        extlib_inheritable_accessor :hidden_actions
        self.hidden_actions ||= Set.new
      end
    end
    
    def action_methods() self.class.action_names end
    def action_names() action_methods end    
    
    module ClassMethods
      def hide_action(*args)
        args.each do |arg|
          self.hidden_actions << arg.to_s
        end
      end
      
      def action_methods
        @action_names ||= Set.new(super.reject {|name| self.hidden_actions.include?(name.to_s)})
      end

      def self.action_names() action_methods end
    end
  end
end