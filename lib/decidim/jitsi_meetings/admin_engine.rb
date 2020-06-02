# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    # This is the engine that runs on the public interface of `JitsiMeetings`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::JitsiMeetings::Admin

      paths["db/migrate"] = nil
      # paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        post "/", to: "jitsi_meetings#update", as: :jitsi_meeting
        root to: "jitsi_meetings#edit"
      end

      def load_seed
        nil
      end
    end
  end
end
