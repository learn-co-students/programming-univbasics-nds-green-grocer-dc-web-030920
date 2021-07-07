require "pry"
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  # pp collection
  collection.each { |data|
    if name == data[:item]
      return data
    end 
  }
  return nil
end

# rspec ./spec/grocer_spec.rb:77
def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  new_arr = []
  row = 0 
  while row < cart.length do
    new_arr_item = find_item_by_name_in_collection(cart[row][:item], new_arr)
    if new_arr_item != nil
      new_arr_item[:count] += 1 
    else
      new_arr_item ={
        :item => cart[row][:item],
        :price => cart[row][:price],
        :clearance => cart[row][:clearance],
        :count => 1  
      }
      new_arr << new_arr_item
    end
    row += 1
  end
    new_arr
end
# rspec ./spec/grocer_spec.rb:77
def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
#   # cart = [
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
#   {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
# ]
# # coupon = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]
# # result
# #  return = [
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
#   {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2}
# ]

#   pp cart
#   puts "************"
#   pp coupons

  counter = 0
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item = "#{coupons[counter][:item]} W/COUPON"
    cart_with_coupon_item = find_item_by_name_in_collection(couponed_item, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_with_coupon_item
        cart_with_coupon_item[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_with_coupon_item = {
          :item => couponed_item,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
  
        }
        cart << cart_with_coupon_item
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    
    counter += 1
  end 
    
   cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_arr =[]
  cart.each do |item|
    if item[:clearance]
      item[:price] = item[:price] - item[:price] * 0.2
    end
    new_arr << item
  end
  new_arr
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
  
  new_cart = consolidate_cart(cart)
  discounted_cart = apply_clearance(apply_coupons(new_cart, coupons))
  grand_total = 0.0
  i = 0 
  while i < discounted_cart.length do 
    grand_total += discounted_cart[i][:price] * discounted_cart[i][:count]
    i += 1
  end
  if grand_total >= 100 
    grand_total = grand_total - grand_total * 0.1
  end
  grand_total
end


 
