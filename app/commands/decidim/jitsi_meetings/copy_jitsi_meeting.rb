# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    # Command that gets called whenever a component's page has to be duplicated.
    # It's need a context with the old component that
    # is going to be duplicated on the new one
    class CopyJitsiMeeting < Rectify::Command
      def initialize(context)
        @context = context
      end

      def call
        Decidim::JitsiMeetings::JitsiMeeting.transaction do
          jitsi_meetings = Decidim::JitsiMeetings::JitsiMeeting.where(component: @context[:old_component])
          jitsi_meetings.each do |jitsi_meeting|
            Decidim::JitsiMeetings::JitsiMeeting.create!(component: @context[:new_component], api: jitsi_meeting.api, domain: jitsi_meeting.domain, room_name: jitsi_meeting.room_name)
          end
        end
        broadcast(:ok)
      rescue ActiveRecord::RecordInvalid
        broadcast(:invalid)
      end
    end
  end
end