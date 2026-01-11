require "rails_helper"

RSpec.describe TaskComponent, type: :component do
  it "renderiza o status verde quando completada" do
    task = Task.new(title: "Feito", completed: true)

    render_inline(described_class.new(task: task))

    # Verifica se existe a classe de cor verde
    expect(page).to have_css("span.bg-green-100")
    expect(page).to have_text("Concluída")
  end

  it "renderiza o status amarelo quando pendente" do
    task = Task.new(title: "Pendente", completed: false)

    render_inline(described_class.new(task: task))

    expect(page).to have_css("span.bg-amber-100")
    expect(page).to have_text("Pendente")
  end
end
