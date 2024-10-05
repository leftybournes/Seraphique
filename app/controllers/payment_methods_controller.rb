class PaymentMethodsController < ApplicationController
    def index
    end

    def new
        @payment_card = PaymentCard.new
    end
end
