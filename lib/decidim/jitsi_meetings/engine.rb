# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module JitsiMeetings
    # This is the engine that runs on the public interface of jitsi_meetings.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::JitsiMeetings

      routes do
        # Add engine routes here
        resources :jitsi_meetings, only: [:show], controller: :application
        root to: "application#show"
      end

      initializer "decidim_jitsi_meetings.assets" do |app|
        app.config.assets.precompile += %w[decidim_jitsi_meetings_manifest.js decidim_jitsi_meetings_manifest.css]
      end
    end
  end
end
