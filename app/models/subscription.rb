class Subscription < ActiveRecord::Base
  extend Displayable
  belongs_to :plan
  attr_accessor :stripe_card_token
  
  def save_with_payment(user)
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_customer_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::APIError => e
    logger.error "Stripe Authentication error while creating user: #{e.message}"
    errors.add :base, "Our system is temporarily unable to process credit cards."
    false
  end

  def cancel_subscription_plan
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    customer.cancel_subscription()
    user.update_attributes(:payment_status => false)
    true
  rescue Stripe::APIError => e
    logger.error "Stripe access error while cancelling subscription plan: #{e.message}"
    errors.add :base, "Our system is temporarily unable to cancel the plan, please try again after a little while."
    false
  end

  def save_plan_user(user)
    if plan.users.first.present != user
      plan.users << user
      plan.save!
    end
  end

end
