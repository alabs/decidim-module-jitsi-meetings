# frozen_string_literal: true

require "spec_helper"

module Decidim
  module JitsiMeetings
    describe JitsiMeeting do
      subject { jitsi_meeting }

      let(:jitsi_meeting) { create(:jitsi_meeting) }

      include_examples "has component"
      include_examples "resourceable"

      it { is_expected.to be_valid }
      it { is_expected.to be_versioned }

      context "without a component" do
        let(:jitsi_meeting) { build :jitsi_meeting, component: nil }

        it { is_expected.not_to be_valid }
      end

      context "without a valid component" do
        let(:jitsi_meeting) { build :jitsi_meeting, component: build(:component, manifest_name: "proposals") }

        it { is_expected.not_to be_valid }
      end

      it "has an associated component" do
        expect(jitsi_meeting.component).to be_a(Decidim::Component)
      end
    end
  end
end