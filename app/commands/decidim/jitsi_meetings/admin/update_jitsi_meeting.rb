# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    module Admin
      # This command is executed when the user changes a Jitsi Meeting from the admin
      # panel.
      class UpdateJitsiMeeting < Rectify::Command
        # Initializes a UpdatePage Command.
        #
        # form - The form from which to get the data.
        # jitsi_meeting - The current instance of the page to be updated.
        def initialize(form, jitsi_meeting)
          @form = form
          @jitsi_meeting = jitsi_meeting
        end

        # Updates the jitsi meeting if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if @form.invalid?

          update_jitsi_meeting
          broadcast(:ok)
        end

        private

        def update_jitsi_meeting
          Decidim.traceability.update!(
            @jitsi_meeting,
            @form.current_user,
            api: @form.api,
            domain: @form.domain,
            room_name: @form.room_name
          )
        end
      end
    end
  end
end