require_relative 'grocer'

def items
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
end

def coupons
	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]
end

def generate_cart
	[].tap do |cart|
		rand(20).times do
			cart.push(items.sample)
		end
	end
end

def generate_coupons
	[].tap do |c|
		rand(2).times do
			c.push(coupons.sample)
		end
	end
end

cart = generate_cart
coupons = generate_coupons

puts "Items in cart"
cart.each do |item|
	puts "Item: #{item.keys.first}"
	puts "Price: #{item[item.keys.first][:price]}"
	puts "Clearance: #{item[item.keys.first][:clearance]}"
	puts "=" * 10
end

puts "Coupons on hand"
coupons.each do |coupon|
	puts "Get #{coupon[:item].capitalize} for #{coupon[:cost]} when you by #{coupon[:num]}"
end

puts "Your total is #{checkout(cart: cart, coupons: coupons)}"

def find_item_by_name_in_collection (string, array)
  
end

def consolidate_cart(cart:[])
consolidated_cart = {}

    cart.each do |item|
     item_name = item.keys[0]

      consolidated_cart[item_name] = item.values[0]

      if consolidated_cart[item_name][:count] 
       consolidated_cart[item_name][:count] += 1
     else
       consolidated_cart[item_name][:count] = 1
     end
   end

    consolidated_cart
end

def apply_coupons(cart:[], coupons:[])
   # code here		   coupons.each do |coupon|
     coupon_name = coupon[:item]
     coupon_item_num = coupon[:num]
     cart_item = cart[coupon_name]

      next if cart_item.nil? || cart_item[:count] < coupon_item_num

      cart_item[:count] -= coupon_item_num

      coupon_in_cart = cart["#{coupon_name} W/COUPON"]

      if coupon_in_cart
       coupon_in_cart[:count] += 1
     else
       cart["#{coupon_name} W/COUPON"] = { 
         price: coupon[:cost], 
         clearance: cart_item[:clearance], 
         count: 1
       }
     end
   end

    cart
  end
  



