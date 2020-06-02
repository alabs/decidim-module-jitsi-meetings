# frozen_string_literal: true

require "spec_helper"

module Decidim
  module JitsiMeetings
    describe CreateJitsiMeeting do
      describe "call" do
        let(:component) { create(:component, manifest_name: "jitsi_meetings") }
        let(:command) { described_class.new(component) }

        describe "when the jitsi_meetings is not saved" do
          before do
            # rubocop:disable RSpec/AnyInstance
            expect_any_instance_of(JitsiMeeting).to receive(:save).and_return(false)
            # rubocop:enable RSpec/AnyInstance
          end

          it "broadcasts invalid" do
            expect { command.call }.to broadcast(:invalid)
          end

          it "doesn't create a jitsi_meeting" do
            expect do
              command.call
            end.not_to change(JitsiMeeting, :count)
          end
        end

        describe "when the jitsi_meeting is saved" do
          it "broadcasts ok" do
            expect { command.call }.to broadcast(:ok)
          end

          it "creates a new jitsi_meeting with the same name as the component" do
            expect(JitsiMeeting).to receive(:new).with(component: component).and_call_original

            expect do
              command.call
            end.to change(JitsiMeeting, :count).by(1)
          end
        end
      end
    end
  end
end