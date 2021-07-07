require 'pp'

def pretty_print_cart(nds)
  pp cart
end 

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0 
  r = nil
    while index < collection.length do 
    if collection[index][:item] == name
      r = collection[index]
    end
    index += 1 
  end
  r
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
result = []
index = 0 
  while index < cart.length do 
    cart_item_name = cart[index][:item]
    new_cart_item = cart[index] 
    item_already_in_cart = find_item_by_name_in_collection(cart_item_name, result)
    if item_already_in_cart
      item_already_in_cart[:count] += 1 
    else 
      new_cart_item[:count] = 1 
      result.push(new_cart_item)
    end
    index += 1 
  end
  result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupon_index = 0 
    while coupon_index < coupons.length do 
      cart_item = find_item_by_name_in_collection(coupons[coupon_index][:item], cart)
      item_name_with_coupon = "#{coupons[coupon_index][:item]} W/COUPON"
      cart_with_coupon = find_item_by_name_in_collection(item_name_with_coupon, cart)
      if cart_item && cart_item[:count] >= coupons[coupon_index][:num]
        if cart_with_coupon
          cart_with_coupon[:count] += coupons[coupon_index][:num]
          cart_item[:count] -= coupons[coupon_index][:num]
        else 
          cart_with_coupon = {
            :item => item_name_with_coupon,
            :price => coupons[coupon_index][:cost]/coupons[coupon_index][:num],
            :clearance => cart_item[:clearance],
            :count => coupons[coupon_index][:num]
          }
          cart << cart_with_coupon
          cart_item[:count] -= coupons[coupon_index][:num]
        end
      end
      coupon_index += 1 
    end 
  cart
end
  

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < cart.length do
    if cart[index][:clearance] == true 
      cart[index][:price] = (cart[index][:price]* 0.80).round(2)
    end
    index += 1 
  end 
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0 
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance (cart)
  index = 0 
    while index < cart.length do
      item_total = cart[index][:price]*cart[index][:count]
      total += item_total
      index += 1
    end
    if total > 100 
      total = total*0.90
    end
    total
end
