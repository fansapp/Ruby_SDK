Rails.application.routes.draw do
  root 'home#index'
  match "hosted_payment_simple", to: "hosted_payment#simple", via: [:get, :post]
  match "hosted_payment_silent", to: "hosted_payment#silent", via: [:get, :post]
  match "hosted_payment_silent_card", to: "hosted_payment#silent_card", via: [:get, :post]
  match "card_payment_simple", to: "card_payment#simple", via: [:get, :post]
  match "card_payment_customer_vault", to: "card_payment#customer_vault", via: [:get, :post]
end
