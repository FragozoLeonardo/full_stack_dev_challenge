class TaskComponent < ViewComponent::Base
  include Rails.application.routes.url_helpers
  def initialize(task:)
    @task = task
  end
end
