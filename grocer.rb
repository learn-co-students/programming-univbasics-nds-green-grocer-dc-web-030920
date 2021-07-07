

def find_item_by_name_in_collection(name, collection)
  
  collection_index = 0 
  while collection_index < collection.length do 
      if name == collection[collection_index][:item]
        return collection[collection_index]
      end 
        collection_index += 1  
  end
end

def consolidate_cart(cart)
  consolidated_cart = []

  cart.each do |n|
    found_item = find_item_by_name_in_collection(n[:item], consolidated_cart)

    if found_item != nil
      found_item[:count] += 1
    else
      consolidated_cart.push(n)
      consolidated_cart.last[:count] = 1
    end
  end

  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |discount|
    item_in_cart = find_item_by_name_in_collection(discount[:item], cart)
    if (item_in_cart != nil)
      if (item_in_cart[:count] >= discount[:num])
        item_in_cart[:count] -= discount[:num]
        cart.push(
          {
            item: "#{discount[:item]} W/COUPON",
            price: (discount[:cost] / discount[:num]),
            clearance: item_in_cart[:clearance],
            count: discount[:num]
          }
        )
      elsif (item_in_cart[:discount] == discount[:num])
          item_in_cart[:item] = "#{discount[:item]} W/COUPON"
          item_in_cart[:price] = (discount[:cost] / discount[:num])
      end
    end
  end 

  cart 
end

def apply_clearance(cart)
  cart.each do |item|
    if (item[:clearance] == true)
      item[:price] = (item[:price] * 0.8).round(2)
    end
  end

  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupons_cart)

  total = 0
  i = 0
  while i < clearance_cart.length do 
    total += clearance_cart[i][:price] * clearance_cart[i][:count]
    i+=1 
  end

  if total > 100 
    total = total - total * 0.1
    total.round(2)
  end

  total
end
