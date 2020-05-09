class ChangeDefaultPurchaseCurrency < ActiveRecord::Migration[5.2]
  def up
    change_column :purchases, :price_currency, :string, default: 'EUR', null: false
  end

  def down
    change_column :purchases, :price_currency, :string, default: 'USD', null: false
  end
end
