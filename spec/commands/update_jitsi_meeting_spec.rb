# frozen_string_literal: true

require "spec_helper"

module Decidim
  module JitsiMeetings
    module Admin
      describe UpdateJitsiMeeting do
        let(:current_organization) { create(:organization) }
        let(:user) { create(:user, organization: current_organization) }
        let(:participatory_process) { create(:participatory_process, organization: current_organization) }
        let(:component) { create(:component, manifest_name: "jitsi_meetings", participatory_space: participatory_process) }
        let(:jitsi_meeting) { create(:jitsi_meeting, component: component) }
        let(:form_params) do
          {
            "api" => { "en" => "https://meet.jit.si/external_api.js" },
            "domain" => { "en" => "meet.jit.si" },
            "room_name" => { "en" => "Module-Jitsi-Meetings" }
          }
        end
        let(:form) do
          JitsiMeetingForm.from_params(
            form_params
          ).with_context(
            current_user: user,
            current_organization: current_organization
          )
        end
        let(:command) { described_class.new(form, jitsi_meeting) }

        describe "when the form is invalid" do
          before do
            expect(form).to receive(:invalid?).and_return(true)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't update the page" do
            expect(jitsi_meeting).not_to receive(:update!)
            command.call
          end
        end

        describe "when the form is valid" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new page with the same name as the component" do
            expect(jitsi_meeting).to receive(:update!)
            command.call
          end

          it "traces tyhe action", versioning: true do
            expect(Decidim.traceability)
              .to receive(:update!)
              .with(jitsi_meeting, user, api: form.api, domain: form.domain, room_name: form.room_name) 
              .and_call_original

            expect { command.call }.to change(Decidim::ActionLog, :count)
            action_log = Decidim::ActionLog.last
            expect(action_log.version).to be_present
            expect(action_log.version.event).to eq "update"
          end
        end
      end
    end
  end
end