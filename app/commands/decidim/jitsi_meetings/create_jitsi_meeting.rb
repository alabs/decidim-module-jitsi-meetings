# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    # Command that gets called whenever a component's jitsi meeting has to be created. It
    # usually happens as a callback when the component itself is created.
    class CreateJitsiMeeting < Rectify::Command
      def initialize(component)
        @component = component
      end

      def call
        @jitsi_meeting = JitsiMeeting.new(component: @component)

        @jitsi_meeting.save ? broadcast(:ok) : broadcast(:invalid)
      end
    end
  end
end