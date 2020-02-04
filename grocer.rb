require 'pry'
def find_item_by_name_in_collection(name, collection)
i = 0
array =[]

while i < collection.length do

  if collection[i][:item] == name
    return collection[i]
  end
  i+=1
end
end

# while i < collection.length
#     movies = collection[i]
#     if !result[movies[:studio]]
#       result[movies[:studio]] = movies[:worldwide_gross]
#     else
#       result[movies[:studio]] += movies[:worldwide_gross]
#     end
#     i +=1
#   end
def consolidate_cart(cart)
#   [{:item => "AVOCADO", :price => 3.00, :clearance => true },
#   {:item => "AVOCADO", :price => 3.00, :clearance => true },
#   {:item => "KALE", :price => 3.00, :clearance => false}]
  new_cart = []
  i = 0
  while i < cart.length do
     new_cart_item = find_item_by_name_in_collection(cart[i][:item], new_cart)
if new_cart_item != nil
  new_cart_item[:count] += 1
else
  new_cart_item = {
    :item=> cart[i][:item],
    :price => cart[i][:price],
    :clearance => cart[i][:clearance],
    :count => 1
  }
  new_cart << new_cart_item
end
    i+=1
  end
  new_cart
end

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.


def apply_coupons(cart, coupons)
i = 0
while i<coupons.length
  cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
  couponed_item_name = "#{coupons[i][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item &&  cart_item[:count] >= coupons[i][:num]
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[i][:num ]
      cart_item -= coupons[i][:num]
    else
      cart_item_with_coupon =
      {   :item=>couponed_item_name,
          :price=>coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance=>cart_item[:clearance]
      }
      cart << cart_item_with_coupon
      cart_item[:count] -= coupons[i][:num]

    end

  end
  i += 1
end
cart
end
  #cart     [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>2}]
  #coupons  [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


def apply_clearance(cart)
  twenty_percent = 8/10
  i = 0
  while i < cart.length
if cart[i][:clearance] == true
  cart[i][:price] *= 8/10.to_f
end
i += 1
  end
  cart
  end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


def checkout(cart, coupons)
  i=0
  total=0
  total_cart = consolidate_cart(cart)
  apply_coupons(total_cart, coupons)
  apply_clearance(total_cart)

   while i < total_cart.length do
     total += total_cart[i][:price] * total_cart[i][:count]
     i += 1

 end
   if total >= 100
      total *= 9/10.to_f
    end
total.round(2)
end
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
