# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    JitsiMeetingsType = GraphQL::ObjectType.define do
      interfaces [-> { Decidim::Core::ComponentInterface }]

      name "JitsiMeetings"
      description "A jitsi meetings component of a participatory space."

      connection :jitsi_meetings, JitsiMeetingType.connection_type do
        resolve ->(component, _args, _ctx) {
                  JitsiMeetingsTypeHelper.base_scope(component).includes(:component)
                }
      end

      field(:jitsi_meeting, JitsiMeetingType) do
        argument :id, !types.ID

        resolve ->(component, args, _ctx) {
          JitsiMeetingsTypeHelper.base_scope(component).find_by(id: args[:id])
        }
      end
    end

    module JitsiMeetingsTypeHelper
      def self.base_scope(component)
        JitsiMeeting.where(component: component)
      end
    end
  end
end