require "pry"

def find_item_by_name_in_collection(name, collection)
  output = nil
  collection.each do |key|
    if name == key[:item]
      output = key
    end
  end
  return output
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  cart.each do |key|
    new_item = find_item_by_name_in_collection(key[:item], new_cart)
    if new_item != nil
      new_item[:count] += 1
    else
      new_item = {
        :item => key[:item],
        :price => key[:price],
        :clearance => key[:clearance],
        :count => 1
      }
      new_cart << new_item
  end
end
  new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |key|
    item = find_item_by_name_in_collection(key[:item], cart)
    puts item
    coupon_item = "#{key[:item]} W/COUPON"
    item_with_coupon = find_item_by_name_in_collection(coupon_item, cart)
    if item && item[:count] >= key[:num]
      if item_with_coupon
        item_with_coupon[:count] += key[:num]
        item[:count] -= key[:num]
      else
        item_with_coupon = {
          :item => coupon_item,
          :price => key[:cost] / key[:num],
          :count => key[:num],
          :clearance => item[:clearance]
        }
      end
      cart << item_with_coupon
      item[:count] -= key[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.map do |key|
    if key[:clearance] == true
      key[:price] = (key[:price] * 0.8).round(2)
    end
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
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  grand_total = 0
  final_cart.each do |key|
    grand_total += (key[:price] * key[:count])
  end
  if grand_total > 100
    grand_total -= (grand_total * 0.1)
  end
  return grand_total
end
