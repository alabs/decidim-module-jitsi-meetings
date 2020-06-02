# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :jitsi_meetings_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :jitsi_meetings).i18n_name }
    manifest_name :jitsi_meetings
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
