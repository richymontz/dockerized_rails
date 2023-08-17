require 'rails_helper'

RSpec.describe "Urls", type: :request do
  describe "POST /create_url", focus: true do
    let(:parsed_response) { JSON.parse(response.body) }
    let(:long_url) { 'http://www.google.com' }
    let(:expected_response) do
      {
        long_url: long_url,
        short_url: Url.generate_short_url(long_url),
        title: nil
      }
    end

    before do
      post "/create_url", params: { url: long_url }
    end
    
    it { expect(response).to have_http_status(:created) }
    it { expect(parsed_response['long_url']).to eq(expected_response[:long_url]) }
    it { expect(parsed_response['short_url']).to eq(expected_response[:short_url]) }
    it { expect(parsed_response['title']).to eq(expected_response[:title]) }
  end

  describe "GET /*" do
    let!(:url) { create(:url, :with_short_url) }

    context "when a URL containing the requested short url exists" do
      before do
        get "/#{url.short_url}"
      end

      it "redirects to the long url" do
        expect(response).to redirect_to(url.long_url)
      end
    end

    context "when a URL containing the requested short url does not exist" do
      let!(:url) { create(:url) }

      before do
        get "/shorty"
      end

      it "returns a 404 status code" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
