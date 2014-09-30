json.array!(@wallets) do |wallet|
  json.extract! wallet, :id, :user_id, :balance
  json.url wallet_url(wallet, format: :json)
end
