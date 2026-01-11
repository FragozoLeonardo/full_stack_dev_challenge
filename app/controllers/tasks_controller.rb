class TasksController < ApplicationController
  def index
    # Cria uma task de exemplo se não existir (para o teste rodar de primeira)
    @task = Task.first_or_create(title: "Teste Técnico Rails", completed: false)
  end

  def sync
    @task = Task.find(params[:id])

    service = UserSynchronizerService.new(@task)

    if service.call
      render json: {
        name: @task.external_user_name,
        company: @task.external_company,
        city: @task.external_city
      }
    else
      render json: { error: "Falha ao sincronizar" }, status: :unprocessable_entity
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed) # Inverte o valor booleano

    render json: {
      completed: @task.completed,
      status_text: @task.completed ? "Concluída" : "Pendente"
    }
  end
end
