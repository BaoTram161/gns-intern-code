class OrderMailer < ApplicationMailer
  def received(order)
    @order = order
    mail to: order.email, subject: "Pragmatic Store Order Confirmation"
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: "Pragmatic Store Order Shipped"
  end
end