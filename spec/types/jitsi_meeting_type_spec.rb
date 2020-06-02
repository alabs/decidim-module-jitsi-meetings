# frozen_string_literal: true

require "spec_helper"
require "decidim/api/test/type_context"

module Decidim
  module JitsiMeetings
    describe JitsiMeetingType, type: :graphql do
      include_context "with a graphql type"

      let(:model) { create(:jitsi_meeting) }

      describe "id" do
        let(:query) { "{ id }" }

        it "returns all the required fields" do
          expect(response).to include("id" => model.id.to_s)
        end
      end

      describe "api" do
        let(:query) { '{ api { translation(locale: "en")}}' }

        it "returns all the required fields" do
          expect(response["api"]["translation"]).to eq(model.api["en"])
        end
      end

      describe "domain" do
        let(:query) { '{ domain { translation(locale: "en")}}' }

        it "returns all the required fields" do
          expect(response["domain"]["translation"]).to eq(model.domain["en"])
        end
      end

      describe "room_name" do
        let(:query) { '{ room_name { translation(locale: "en")}}' }

        it "returns all the required fields" do
          expect(response["room_name"]["translation"]).to eq(model.room_name["en"])
        end
      end

      describe "createdAt" do
        let(:query) { "{ createdAt }" }

        it "returns when the jitsi_meeting was created" do
          expect(response["createdAt"]).to eq(model.created_at.to_time.iso8601)
        end
      end

      describe "updatedAt" do
        let(:query) { "{ updatedAt }" }

        it "returns when the jitsi_meeting was updated" do
          expect(response["updatedAt"]).to eq(model.updated_at.to_time.iso8601)
        end
      end
    end
  end
end