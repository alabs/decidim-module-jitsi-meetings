# frozen_string_literal: true

require "spec_helper"

module Decidim
  module JitsiMeetings
    describe CopyJitsiMeeting do
      describe "call" do
        let(:component) { create(:component, manifest_name: "jitsi_meetings") }
        let!(:jitsi_meeting) { create(:jitsi_meeting, component: component) }
        let(:new_component) { create(:component, manifest_name: "jitsi_meetings") }
        let(:context) { { new_component: new_component, old_component: component } }
        let(:command) { described_class.new(context) }

        describe "when the jitsi_meeting is not duplicated" do
          before do
            allow(JitsiMeeting).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't duplicate the jitsi_meeting" do
            expect do
              command.call
            end.not_to change(JitsiMeeting, :count)
          end
        end

        describe "when the jitsi_meeting is duplicated" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "duplicates the jitsi_meeting and its values" do
            expect(JitsiMeeting).to receive(:create!).with(component: new_component, api: jitsi_meeting.api, domain: jitsi_meeting.domain, room_name: jitsi_meeting.room_name).and_call_original

            expect do
              command.call
            end.to change(JitsiMeeting, :count).by(1)
          end
        end
      end
    end
  end
end