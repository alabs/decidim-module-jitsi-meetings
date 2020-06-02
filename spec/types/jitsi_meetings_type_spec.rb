# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"
require "decidim/core/test"

module Decidim
  module JitsiMeetings
    describe JitsiMeetingsType, type: :graphql do
      include_context "with a graphql type"
      let(:model) { create(:jitsi_meeting_component) }

      it_behaves_like "a component query type"

      describe "jitsi_meetings" do
        let!(:component_jitsi_meetings) { create_list(:jitsi_meeting, 2, component: model) }
        let!(:other_jitsi_meetings) { create_list(:jitsi_meeting, 2) }

        let(:query) { "{ jitsi_meetings { edges { node { id } } } }" }

        it "returns the published jitsi_meetings" do
          ids = response["jitsi_meetings"]["edges"].map { |edge| edge["node"]["id"] }
          expect(ids).to include(*component_jitsi_meetings.map(&:id).map(&:to_s))
          expect(ids).not_to include(*other_jitsi_meetings.map(&:id).map(&:to_s))
        end
      end

      describe "jitsi_meeting" do
        let(:query) { "query JitsiMeeting($id: ID!){ jitsi_meeting(id: $id) { id } }" }
        let(:variables) { { id: jitsi_meeting.id.to_s } }

        context "when the jitsi_meeting belongs to the component" do
          let!(:jitsi_meeting) { create(:jitsi_meeting, component: model) }

          it "finds the jitsi_meeting" do
            expect(response["jitsi_meeting"]["id"]).to eq(jitsi_meeting.id.to_s)
          end
        end

        context "when the jitsi_meeting doesn't belong to the component" do
          let!(:jitsi_meeting) { create(:jitsi_meeting, component: create(:jitsi_meeting_component)) }

          it "returns null" do
            expect(response["jitsi_meeting"]).to be_nil
          end
        end
      end
    end
  end
end