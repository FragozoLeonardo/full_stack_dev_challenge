# 🚀 Desafio Técnico - Rails Full Stack (Pleno) - Leonardo Quadros Fragozo

Uma aplicação Rails focada em **interatividade moderna** (SPA-feel), **arquitetura limpa** e **componentização**, desenvolvida como parte do processo seletivo para a vaga de Ruby on Rails Pleno.

O objetivo foi criar uma interface reativa para gerenciamento de tarefas e sincronização de dados externos sem a necessidade de recarregar a página.

![Ruby](https://img.shields.io/badge/Ruby-3.x-red)
![Rails](https://img.shields.io/badge/Rails-8.x-red)
![TailwindCSS](https://img.shields.io/badge/Tailwind-CSS-blue)
![RSpec](https://img.shields.io/badge/Tests-RSpec-green)

---

## 🎯 Funcionalidades Entregues

1.  **Sincronização via API Externa:**
    * Consumo da API `JSONPlaceholder` para buscar dados de usuário (Nome, Empresa, Cidade).
    * Implementação robusta prevendo falhas de conexão.

2.  **Interatividade sem Reload (Hotwire/Stimulus):**
    * Atualização do DOM via JavaScript moderno.
    * **Toggle de Status Otimista:** O status muda instantaneamente na tela com feedback visual, enquanto a requisição é processada em background.

3.  **UI/UX Premium:**
    * Interface construída com **TailwindCSS** e **Flowbite**.
    * Design responsivo, uso de sombras suaves, feedback de *loading* e transições de estado.

---

## 🏗️ Decisões de Arquitetura

Para garantir manutenibilidade e escalabilidade, o código evitou a lógica excessiva em Controllers e Views padrão.

### 1. Service Objects (`UserSynchronizerService`)
A lógica de consumo da API externa foi isolada em um serviço dedicado.
* **Por que?** Garante o *Single Responsibility Principle (SRP)*. O Controller não precisa saber como a requisição HTTP é feita, apenas chama o serviço.
* **Benefício:** Facilita testes unitários e tratamento de exceções (ex: timeouts, 404).

### 2. ViewComponents (`TaskComponent`)
A interface do Card da tarefa foi encapsulada em um componente.
* **Por que?** Permite isolar a lógica de apresentação (ex: escolher a cor do badge `green` ou `amber` baseada no estado) fora dos helpers globais.
* **Benefício:** Reutilização e facilidade em testar a renderização isolada.

### 3. Stimulus Controllers (`user_sync_controller.js`)
O JavaScript foi organizado seguindo o padrão do Hotwire.
* **Por que?** Mantém o HTML como a "fonte da verdade". O Controller JS lê os `data-attributes` do HTML para saber onde buscar os dados e quais elementos atualizar.

---

## 🛠️ Stack Tecnológica

* **Backend:** Ruby on Rails 8.1
* **Frontend:** ViewComponent, TailwindCSS, Flowbite
* **Javascript:** Hotwire (Stimulus)
* **HTTP Client:** Faraday (pela legibilidade e facilidade de mock)
* **Testes:** RSpec, FactoryBot, Faker

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos
* Ruby 3+
* Node.js & Yarn

### Passo a Passo

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/FragozoLeonardo/full_stack_dev_challenge](https://github.com/FragozoLeonardo/full_stack_dev_challenge.git)
    cd challenge_fullstack
    ```

2.  **Instale as dependências:**
    ```bash
    bundle install
    yarn install
    ```

3.  **Configure o Banco de Dados:**
    ```bash
    bin/rails db:create db:migrate
    ```

4.  **Inicie o Servidor:**
    > ⚠️ **Importante:** Utilize o comando `bin/dev` para garantir que o TailwindCSS observe as alterações e compile os estilos corretamente. Não use apenas `rails s`.

    ```bash
    bin/dev
    ```

5.  **Acesse:**
    Abra `http://localhost:3000` no seu navegador.

---

## ✅ Testes Automatizados

O projeto conta com uma suíte de testes focada nas regras de negócio e integração.

Para rodar os testes:
```bash
bundle exec rspec