
teas = ["Earl Grey", "Lady Grey", "Green", "Oolong", "Constat Comment", "Mint", "Kava"]
descriptions = ["MMMM Tea", "Yummm", "Get that caffeine", "I wish this was coffee", "What is this", "Only the finest", "Leaf water good"]
times = [1.00, 2.00, 3.00, 4.00]
temps = [120, 125, 130, 140, 145]

10.times do 
  Tea.create(title: teas.sample, description: descriptions.sample, brew_time: times.sample, temp: temps.sample )
end

customer = Customer.create(first_name: "matt", last_name: "smith", email: "msmith@example.com", address: "1234 Sample Address")

Subscription.create(title: "Wake up", price: 20.00, status: "active", frequency: "weekly", customer_id: customer.id, tea_id: Tea.first.id )
Subscription.create(title: "Sleep well", price: 10.00, status: "active", frequency: "monthly", customer_id: customer.id, tea_id: Tea.last.id)
