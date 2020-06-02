# frozen_string_literal: true

require "spec_helper"

module Decidim
  module JitsiMeetings
    module Admin
      describe JitsiMeetingForm do
        subject do
          described_class.from_params(attributes).with_context(
            current_organization: current_organization
          )
        end

        let(:current_organization) { create(:organization) }

        let(:api) do
          {
            "en" => "https://meet.jit.si/external_api.js",
            "ca" => "https://meet.jit.si/external_api.js",
            "es" => "https://meet.jit.si/external_api.js"
          }
        end

        let(:domain) do
          {
            "en" => "meet.jit.si",
            "ca" => "meet.jit.si",
            "es" => "meet.jit.si"
          }
        end

        let(:room_name) do
          {
            "en" => "Module-Jitsi-Meetings",
            "ca" => "Module-Jitsi-Meetings",
            "es" => "Module-Jitsi-Meetings"
          }
        end

        let(:commentable) { true }

        let(:attributes) do
          {
            "jitsi_meeting" => {
              "api" => api,
              "domain" => domain,
              "room_name" => room_name,
              "commentable" => commentable
            }
          }
        end

        context "when everything is OK" do
          it { is_expected.to be_valid }
        end
      end
    end
  end
end