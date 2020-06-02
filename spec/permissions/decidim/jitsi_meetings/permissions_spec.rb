# frozen_string_literal: true

require "spec_helper"

describe Decidim::JitsiMeetings::Permissions do
  subject { described_class.new(user, permission_action, context).permissions.allowed? }

  let(:user) { build :user }
  let(:space_allows) { true }
  let(:context) do
    {
      current_component: jitsi_meeting_component
    }
  end
  let(:jitsi_meeting_component) { create :jitsi_meeting_component }
  let(:permission_action) { Decidim::PermissionAction.new(action) }

  context "when updating a jitsi_meeting" do
    let(:action) do
      { scope: :admin, action: :update, subject: :jitsi_meeting }
    end

    it { is_expected.to eq true }
  end

  context "when any other action" do
    let(:action) do
      { scope: :admin, action: :foo, subject: :bar }
    end

    it_behaves_like "permission is not set"
  end
end