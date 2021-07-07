def find_item_by_name_in_collection(name, collection)
    x = 0 
    while x < collection.length do 
      if collection[x][:item] == name 
        return collection[x]
     # else 
     #   nil 
      end 
      x += 1 
    end 
  # Implement me first!
  #
  # Consult README for inputs and outputs
end




def consolidate_cart(cart)
  
    new_cart = [] 
    i = 0 
    while i < cart.length  
     new_cart_item = find_item_by_name_in_collection(cart[i][:item], new_cart)
     
     if new_cart_item != nil 
       new_cart_item[:count] += 1 
      else 
        new_cart_item = {
          :item => cart[i][:item],
          :price => cart[i][:price],
          :clearance => cart[i][:clearance], 
           :count => 1
        }
        new_cart << new_cart_item
     end 
     i += 1  
   end 
  new_cart 
  
end 







def apply_coupons(cart, coupons)

  x = 0 
  while x < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[x][:item], cart)
    couponed_item_name = "#{coupons[x][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart) 
    
    if cart_item && cart_item[:count] >= coupons[x][:num]
       if cart_item_with_coupon 
         cart_item_with_coupon[:count] += coupons[x][:num]
          cart_item[:count] -= coupons[x][:num]
       
      else 
  
     cart_item_with_coupon = {
      :item => couponed_item_name,
      :price => coupons[x][:cost] / coupons[x][:num], 
       :count => coupons[x][:num],
      :clearance => cart_item[:clearance]
    }
 
      cart << cart_item_with_coupon
      cart_item[:count] -= coupons[x][:num]
      
      end
    end
    x += 1 
  end 
  cart 
end 

 




def apply_clearance(cart)
  
  x = 0 
    while x < cart.length 
      if cart[x][:clearance]
         cart[x][:price] = cart[x][:price]*0.80
          cart[x][:price].round(2) 
     
      end 
       x += 1 
    end 
  cart 
  
end


def checkout(cart, coupons)
  
  new_cart = consolidate_cart(cart) 
  cart_with_applied_coupons = apply_coupons(new_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_applied_coupons)
  
  
  grand_total = 0 
   x = 0 
   
  while x < cart_with_discounts_applied.length do 
      item_qty_times_price = cart_with_discounts_applied[x][:price] * cart_with_discounts_applied[x][:count]
      grand_total += item_qty_times_price
       x += 1 
    end 
   
   if grand_total > 100 
     grand_total -= ( grand_total* 0.10)  
   
   end 
   grand_total.round(2)
   
  end 
  
  

