require 'rails_helper'

RSpec.describe Url, type: :model do
  include ActiveJob::TestHelper

  context "Validations" do
    subject(:url) { build(:url) }
  
    it { is_expected.to be_valid }
  end

  context "Callbacks" do
    subject(:url) { build(:url) }
    let(:website) { "<html><head><title>Test title</title></head><body>Test page</body></html>" }

    before do
      allow_any_instance_of(Scraper).to receive(:request_url).and_return(website)
    end

    context "when saving" do
      it "assigns a short url" do
        url.save!
        expect(url.short_url).to be_present
      end

      context "when URL responds successfully" do
        it "assigns a title" do
          perform_enqueued_jobs do
            url.save!
            url.reload
            expect(url.title).to eq("Test title")
          end
        end
      end

      context "when URL responds with unexpected response" do
        let(:website) { "unexpected" }

        it "raises an error" do
          perform_enqueued_jobs do
            expect { url.save! }.to raise_error NoMethodError
          end
        end
      end
    end
  end
end
