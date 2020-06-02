# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    module Admin
      # This class holds a Form to update Jitsi Meetings from Decidim's admin panel.
      class JitsiMeetingForm < Decidim::Form
        include TranslatableAttributes

        translatable_attribute :api, String
        translatable_attribute :domain, String
        translatable_attribute :room_name, String
      end
    end
  end
end