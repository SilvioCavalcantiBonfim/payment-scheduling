class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments, id: false do |t|
      t.string :id, primary_key: true
      t.datetime :pay_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
