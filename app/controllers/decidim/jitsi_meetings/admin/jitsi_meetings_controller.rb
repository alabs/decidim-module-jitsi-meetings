# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    module Admin
      # This controller allows the user to update a Jitsi Meeting.
      class JitsiMeetingsController < Admin::ApplicationController
        def edit
          enforce_permission_to :update, :jitsi_meeting

          @form = form(Admin::JitsiMeetingForm).from_model(jitsi_meeting)
        end

        def update
          enforce_permission_to :update, :jitsi_meeting

          @form = form(Admin::JitsiMeetingForm).from_params(params)

          Admin::UpdateJitsiMeeting.call(@form, jitsi_meeting) do
            on(:ok) do
              flash[:notice] = I18n.t("jitsi_meetings.update.success", scope: "decidim.jitsi_meetings.admin")
              redirect_to parent_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("jitsi_meetings.update.invalid", scope: "decidim.jitsi_meetings.admin")
              render action: "edit"
            end
          end
        end

        private

        def jitsi_meeting
          @jitsi_meeting ||= JitsiMeetings::JitsiMeeting.find_by(component: current_component)
        end
      end
    end
  end
end