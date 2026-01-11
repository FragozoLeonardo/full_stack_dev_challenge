require 'rails_helper'

RSpec.describe UserSynchronizerService do
  let(:task) { Task.new(title: "Test Task", completed: false) }
  subject { described_class.new(task) }

  describe '#call' do
    context 'quando a API responde com sucesso' do
      let(:fake_response_body) do
        {
          "name" => "Leanne Graham",
          "company" => { "name" => "Romaguera-Crona" },
          "address" => { "city" => "Gwenborough" }
        }.to_json
      end

      before do
        allow(Faraday).to receive(:get).and_return(
          instance_double(Faraday::Response, success?: true, body: fake_response_body)
        )
      end

      it 'atualiza a task com os dados externos' do
        result = subject.call

        expect(result).to be_truthy
        expect(task.external_user_name).to eq("Leanne Graham")
        expect(task.external_company).to eq("Romaguera-Crona")
        expect(task.external_city).to eq("Gwenborough")
      end
    end

    context 'quando a API retorna erro (ex: 500)' do
      before do
        allow(Faraday).to receive(:get).and_return(
          instance_double(Faraday::Response, success?: false)
        )
      end

      it 'não atualiza a task e retorna false' do
        result = subject.call
        expect(result).to be_falsey
        expect(task.external_user_name).to be_nil
      end
    end

    context 'quando a conexão falha (Exception)' do
      before do
        allow(Faraday).to receive(:get).and_raise(Faraday::ConnectionFailed.new("Erro"))
      end

      it 'trata a exceção e retorna false' do
        result = subject.call
        expect(result).to be_falsey
      end
    end
  end
end
