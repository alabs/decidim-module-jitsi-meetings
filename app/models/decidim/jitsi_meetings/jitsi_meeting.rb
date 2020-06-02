# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    # The data store for a Page in the Decidim::Pages component. It stores a
    # title, description and any other useful information to render a custom page.
    class JitsiMeeting < JitsiMeetings::ApplicationRecord
      include Decidim::Resourceable
      include Decidim::HasComponent
      include Decidim::Traceable
      include Decidim::Loggable

      component_manifest_name "jitsi_meetings"

      def self.log_presenter_class_for(_log)
        Decidim::JitsiMeetings::AdminLog::PagePresenter
      end

      # Public: Pages doesn't have title so we assign the component one to it.
      def title
        component.name
      end
    end
  end
end