class UrlsController < ApplicationController
  def create
    @url = Url.create!(long_url: url_attributes[:url])

    render json: @url, status: :created
  rescue StandardError => e
    render json: { error: true, message: e.message }, status: 400
  end

  def get
    short_url = params[:page]
    @url = Url.find_by!(short_url: short_url)

    redirect_to @url.long_url, status: :found, allow_other_host: true
  rescue StandardError => e
    render json: { error: true, message: e.message }, status: 404
  end

  def web_sites
    title = params[:title]
    results = Url.search(title)

    response = build_url_records(results)

    render json: response, status: :ok
  end

  private

  def url_attributes
    params.permit(:url)
  end

  def build_url_records(results)
    results.map { |result| result._source.except(:id, :created_at, :updated_at) }
  end
end
