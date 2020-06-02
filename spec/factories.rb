# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/participatory_processes/test/factories"

FactoryBot.define do
  factory :jitsi_meeting_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :jitsi_meetings).i18n_name }
    manifest_name { :jitsi_meetings }
    participatory_space { create(:participatory_process, :with_steps, organization: organization) }
  end
  
  factory :jitsi_meeting, class: "Decidim::JitsiMeetings::JitsiMeeting" do
    api { { en: "https://meet.jit.si/external_api.js" } }
    domain { { en: "meet.jit.si" } }
    room_name { { en: Faker::Name.unique.name } }
    component { build(:component, manifest_name: "jitsi_meetings") }
  end
end