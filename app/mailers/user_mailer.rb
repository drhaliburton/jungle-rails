class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.ca'
 
  def order_confirm(order, user)
    @user = user
    @order = order
    mail(to: @user.email, subject: @order.id)
  end
end