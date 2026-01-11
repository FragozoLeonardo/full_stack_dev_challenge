# frozen_string_literal: true

class UserSynchronizerService
  EXTERNAL_URL = "https://jsonplaceholder.typicode.com/users/1"

  def initialize(task)
    @task = task
  end

  def call
    response = Faraday.get(EXTERNAL_URL)

    return false unless response.success?

    data = JSON.parse(response.body)

    @task.update(
      external_user_name: data["name"],
      external_company: data.dig("company", "name"),
      external_city: data.dig("address", "city")
    )
  rescue Faraday::Error => e
    Rails.logger.error("API Error: #{e.message}")
    false
  end
end
