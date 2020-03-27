def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
  return nil

end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  consolidated = []
  i = 0
  while i < cart.count do
    name = cart[i][:item]
    check = find_item_by_name_in_collection(name, consolidated)

   if check
     check[:count] +=1
    else
      cart[i][:count] = 1
      consolidated << cart[i]
    end
    i += 1
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupon_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item_name,
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[i][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end

    end

  i += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  clearance = []
  i = 0
  while i < cart.length do
    if cart[i][:clearance]

      cart[i][:price] *= 0.80
      clearance << cart[i]
    else
      clearance << cart[i]
    end

    i += 1
  end
  clearance
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

  c_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(c_cart, coupons)
  clearance = apply_clearance(coupon_cart)

  i=0
  total = 0
  while i < clearance.count
  total += clearance[i][:price] * clearance[i][:count]
  i += 1
  end

  if total > 100
    total *= 0.90

  end
    total.round(2)

end
