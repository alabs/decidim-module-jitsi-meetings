# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    # Command that gets called when the jitsi meeting of this component needs to be
    # destroyed. It usually happens as a callback when the component is removed.
    class DestroyJitsiMeeting < Rectify::Command
      def initialize(component)
        @component = component
      end

      def call
        JitsiMeeting.where(component: @component).destroy_all
        broadcast(:ok)
      end
    end
  end
end