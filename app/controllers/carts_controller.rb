class CartsController < ApplicationController

  def show
    @user = current_user
    @user_name = show_username
    @user_email = show_email
  end

  def add_item
    product_id = params[:product_id].to_s

    item = cart[product_id] || { "quantity" => 0 }
    item["quantity"] += 1
    cart[product_id] = item
    update_cart cart

    redirect_to :back
  end

  def remove_item
    product_id = params[:product_id].to_s

    item = cart[product_id] || { "quantity" => 1 }
    item["quantity"] -= 1
    cart[product_id] = item
    cart.delete(product_id) if item["quantity"] < 1
    update_cart cart

    redirect_to :back
  end

  def show_username
    if current_user
      current_user.first_name
    else
      'Guest'
    end
  end

  def show_email
    if current_user
      current_user.email
    else
      'Guest@guest.ca'
    end
  end

end
