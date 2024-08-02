# db/seeds.rb

# Limpando a tabela antes de semear novos dados
Payment.delete_all

# Criando registros com data e hora
# Payment.create([
#                  { pay_at: DateTime.parse('2024-01-01T10:00:00') },
#                  { pay_at: DateTime.parse('2024-02-01T11:00:00') },
#                  { pay_at: DateTime.parse('2024-03-01T12:00:00') },
#                  { pay_at: DateTime.parse('2024-04-01T13:00:00') }
#                ])

puts 'Seed concluído! Payments foram criados com data e hora.'
