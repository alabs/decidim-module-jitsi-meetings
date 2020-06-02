# frozen_string_literal: true

module Decidim
  module JitsiMeetings
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Components::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class ApplicationController < Decidim::Components::BaseController
      def show
        @jitsi_meeting = JitsiMeeting.find_by(component: current_component)
      end
    end
  end
end
