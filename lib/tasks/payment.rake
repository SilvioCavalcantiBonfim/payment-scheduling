namespace :payment do
  desc 'Update payment at date'
  task update_current: :environment do
    current_time = Time.now
    date_time = current_time.strftime('%Y-%m-%d %H:%M')
    puts "Data atual: #{date_time}"
    Payment.pending.where("strftime('%Y-%m-%d %H:%M', pay_at) = ?", date_time).each(&:paid!)
  end
end
