# frozen_string_literal: true

require_dependency "decidim/components/namer"

Decidim.register_component(:jitsi_meetings) do |component|
  component.engine = Decidim::JitsiMeetings::Engine
  component.admin_engine = Decidim::JitsiMeetings::AdminEngine
  component.icon = "decidim/jitsi_meetings/icon.svg"
  component.permissions_class_name = "Decidim::JitsiMeetings::Permissions"

  component.query_type = "Decidim::JitsiMeetings::JitsiMeetingsType"

  component.on(:create) do |instance|
    Decidim::JitsiMeetings::CreateJitsiMeeting.call(instance) do
      on(:invalid) { raise "Can't create jitsi meeting" }
    end
  end

  component.on(:destroy) do |instance|
    Decidim::JitsiMeetings::DestroyJitsiMeeting.call(instance) do
      on(:error) { raise "Can't destroy jitsi meeting" }
    end
  end

  component.on(:copy) do |context|
    Decidim::JitsiMeetings::CopyJitsiMeeting.call(context) do
      on(:invalid) { raise "Can't duplicate jitsi meeting" }
    end
  end

  component.register_stat :jitsi_meetings_count do |components, start_at, end_at|
    jitsi_meetings = Decidim::JitsiMeetings::JitsiMeeting.where(component: components)
    jitsi_meetings = pages.where("created_at >= ?", start_at) if start_at.present?
    jitsi_meetings = pages.where("created_at <= ?", end_at) if end_at.present?
    jitsi_meetings.count
  end

  component.settings(:global) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
  end

  component.settings(:step) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
  end

  component.register_resource(:jitsi_meeting) do |resource|
    resource.model_class_name = "Decidim::JitsiMeetings::JitsiMeeting"
  end

  component.seeds do |participatory_space|
    component = Decidim::Component.create!(
      name: Decidim::Components::Namer.new(participatory_space.organization.available_locales, :jitsi_meetings).i18n_name,
      manifest_name: :jitsi_meetings,
      published_at: Time.current,
      participatory_space: participatory_space
    )

    Decidim::JitsiMeetings::JitsiMeeting.create!(
      component: component,
      api: {"ca": "https://meet.jit.si/external_api.js", "en": "https://meet.jit.si/external_api.js", "es": "https://meet.jit.si/external_api.js"},
      domain: {"ca": "meet.jit.si", "en": "meet.jit.si", "es": "meet.jit.si"},
      room_name: {"ca": Faker::Name.unique.name, "en": Faker::Name.unique.name, "es": Faker::Name.unique.name},
    )
  end
end
