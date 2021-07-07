require 'pry'

def find_item_by_name_in_collection(name, collection)
  index = 0
  while index < collection.length do
    if collection[index][:item] == name
      # binding.pry
      return collection[index]
    else
      nil
    end
    index += 1
  end
  # collection.each do |item|
  #   if item[:item] == name
  #     return item
  #   end
  # end
  # nil
end

def consolidate_cart(cart)
  new_cart = []
  index = 0
  while index < cart.length
    new_cart_item = find_item_by_name_in_collection(cart[index][:item], new_cart)
    if new_cart_item != nil
      new_cart_item[:count] += 1
      # binding.pry
    else
      new_cart_item = {
        :item => cart[index][:item],
        :price => cart[index][:price],
        :clearance => cart[index][:clearance],
        :count => 1
      }
      new_cart << new_cart_item
    end
    index += 1
  # binding.pry
  end
  new_cart
end

# def apply_coupons(cart, coupons)
#   # Consult README for inputs and outputs
#   #
#   # REMEMBER: This method **should** update cart
#   #array of item hashes
#   #array of coupon hashes
#   i = 0
#   while i < cart.length
#     cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
#     couponed_item_name = "#{coupons[i][:item]} W/COUPON"
#     cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
#     if cart_item &&  cart_item[:count] >= coupons[i][:num]
#       if cart_item_with_coupon
#         cart_item_with_coupon[:count] += coupons[i][:num]
#         cart_item[:count] -= coupons[i][:num]
#       else
#         cart_item_with_coupon = {
#           :item => couponed_item_name,
#           :price => coupons[i][:cost] / coupons[i][:num],
#           :count => coupons[i][:num],
#           :clearance => cart_item[:clearance]
#         }
#         cart << cart_item_with_coupon
#         cart_item[:count] -= coupons[i][:num]
#       end
#     end
#     i += 1
#   end
#   cart
# end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_info = find_item_by_name_in_collection(coupon[:item], cart)
	  item_w_coupon = find_item_by_name_in_collection("#{coupon[:item]} W/COUPON", cart) 
    if item_w_coupon and item_info[:count] >= coupon[:num]
	    item_w_coupon[:count] += coupon[:num]
	    item_info[:count] -= coupon[:num]
	  elsif item_info and item_info[:count] >= coupon[:num]
      cart << {
        :item => coupon[:item] + " W/COUPON",
        :price => (coupon[:cost]/coupon[:num]),
        :clearance => item_info[:clearance],
        :count => coupon[:num]
      }
      # binding.pry
      item_info[:count] -= coupon[:num]
    end #if
  end #each
  cart
end #method apply_coupons

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if item[:clearance]
      item[:price] *= 0.80
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
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  total = 0
  counter = 0
  while counter < applied_clearance.length do
    total += applied_clearance[counter][:price] * applied_clearance[counter][:count]
    counter += 1
  end
  # binding.pry
  if total > 100
    total *= 0.90
  end
    # binding.pry
  total.round(3)
end
