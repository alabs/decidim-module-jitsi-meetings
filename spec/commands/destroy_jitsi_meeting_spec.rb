# frozen_string_literal: true

require "spec_helper"

module Decidim
  module JitsiMeetings
    describe DestroyJitsiMeeting do
      describe "call" do
        let(:component) { create(:component, manifest_name: "jitsi_meetings") }
        let!(:jitsi_meeting) { create(:jitsi_meeting, component: component) }
        let(:command) { described_class.new(component) }

        it "broadcasts ok" do
          expect { command.call }.to broadcast(:ok)
        end

        it "deletes the jitsi_meeting associated to the component" do
          expect do
            command.call
          end.to change(JitsiMeeting, :count).by(-1)
        end
      end
    end
  end
end