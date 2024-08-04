# Agendador Simples

![Ruby](https://img.shields.io/badge/-Ruby-white?style=for-the-badge&logo=ruby&color=CC342D&logoColor=white)
![rails](https://img.shields.io/badge/-Ruby_On_Rails-white?style=for-the-badge&logo=rubyonrails&color=D30001&logoColor=white)
![sqlite](https://img.shields.io/badge/-SQLite-white?style=for-the-badge&logo=sqlite&color=003B57&logoColor=white)

Um aplicativo de agendamento simples desenvolvido com Ruby on Rails que permite gerenciar e agendar pagamentos. O aplicativo utiliza o `whenever` para gerenciar tarefas agendadas com cron jobs.

## Funcionalidades

- Criar, ler e atualizar pagamentos.
- Agendar tarefas usando crontab com a gem `whenever`.

## Requisitos

- Ruby 3.x
- Rails 7.x
- SQLite3
- Cron (para executar tarefas agendadas)
- Gem `whenever` para agendamento de tarefas

## Instalação

1. **Clone o repositório:**

    ```bash
    git clone https://github.com/SilvioCavalcantiBonfim/payment-scheduling.git
    cd payment-scheduling
    ```

2. **Instale as dependências:**

    ```bash
    bundle install
    ```

3. **Configure o banco de dados:**

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. **Configure os jobs do cron:**

    Para configurar os jobs do cron, certifique-se de que você tem o `whenever` instalado. Execute o seguinte comando para atualizar seu crontab:

    ```bash
    bundle exec whenever --update-crontab --set environment=development
    ```

5. **Inicie o servidor Rails:**

    ```bash
    rails server
    ```

6. **Acesse a aplicação:**

    Abra seu navegador e vá para `http://localhost:3000`.

## Licença

Este projeto é licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.
