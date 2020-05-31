Spree::OrderMailer.class_eval do

  def confirm_email(order, resend = false)
    @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
    current_store = @order.store
    subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
    subject += "#{current_store.name} #{Spree.t('order_mailer.confirm_email.subject')} ##{@order.number}"
    mail(to: @order.email, from: from_address, subject: subject)
  end

end  