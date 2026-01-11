require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:task) { Task.create(title: "Task Teste", completed: false) }

  describe "PATCH /tasks/:id/toggle" do
    it "alterna o status da tarefa e retorna JSON correto" do
      patch toggle_task_path(task), headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response["completed"]).to eq(true)
      expect(json_response["status_text"]).to eq("Concluída")

      expect(task.reload.completed).to be(true)
    end
  end

  describe "POST /tasks/:id/sync" do
    before do
      service_double = instance_double(UserSynchronizerService, call: true)
      allow(UserSynchronizerService).to receive(:new).and_return(service_double)
    end

    it "chama o service e retorna sucesso" do
      post sync_task_path(task)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /tasks/:id/sync - Sad Path" do
    before do
      service_double = instance_double(UserSynchronizerService, call: false)
      allow(UserSynchronizerService).to receive(:new).and_return(service_double)
    end

    it "retorna status 422 (Unprocessable Entity) quando a sincronização falha" do
      post sync_task_path(task)

      expect(response).to have_http_status(:unprocessable_content)

      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to be_present
    end
  end
end
