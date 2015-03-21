#encoding: UTF-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Admin User",
                         email: "admin@user.net",
                         password: "adminuser",
                         password_confirmation: "adminuser")
    admin.toggle!(:admin)

    User.create!(name: "Stefan Helber",
                 email: "stefan.helber@prod.uni-hannover.de",
                 password: "foobar",
                 password_confirmation: "foobar")


    User.create!(name: "Susi Sorglos",
                 email: "susi@sorglos.de",
                 password: "foobar",
                 password_confirmation: "foobar")


    99.times do |n|
#      name = Faker::Name.name
      name = "Nutzer-#{n+1}"
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end


    S1 = Site.create!(name: "Frankfurt(M)",
                      codename: "FRA")
    S2 = Site.create!(name: "Berlin-Tegel",
                      codename: "TLX")
    S3 = Site.create!(name: "München",
                      codename: "MUC")
    S4 = Site.create!(name: "Bremen",
                      codename: "BRE")
    S5 = Site.create!(name: "Cottbus",
                      codename: "CBU")
    S6 = Site.create!(name: "Düsseldorf",
                      codename: "DUS")
    S7 = Site.create!(name: "Hamburg",
                      codename: "HAM")
    S8 = Site.create!(name: "Stuttgart",
                      codename: "STR")


    (10..99).each do |n|
      name = "Beispielort-#{n}"
      codename = "C#{n}"
      Site.create!(name: name,
                   codename: codename)
    end


    SuSi1 = Supplysite.create!(site_id: S1.id, supply_quantity: 20)

    SuSi2 = Supplysite.create!(site_id: S2.id, supply_quantity: 25)

    SuSi3 = Supplysite.create!(site_id: S3.id, supply_quantity: 21)

    DeSi1 = Demandsite.create!(site_id: S4.id, demand_quantity: 15)

    DeSi2 = Demandsite.create!(site_id: S5.id, demand_quantity: 17)

    DeSi3 = Demandsite.create!(site_id: S6.id, demand_quantity: 22)

    DeSi4 = Demandsite.create!(site_id: S7.id, demand_quantity: 12)

    TraLi1 = Translink.create!(supplysite_id: SuSi1.id, demandsite_id: DeSi1.id, unit_cost: 6, transport_quantity: 0.0)
    TraLi2 = Translink.create!(supplysite_id: SuSi1.id, demandsite_id: DeSi2.id, unit_cost: 2, transport_quantity: 0.0)
    TraLi3 = Translink.create!(supplysite_id: SuSi1.id, demandsite_id: DeSi3.id, unit_cost: 6, transport_quantity: 0.0)
    TraLi4 = Translink.create!(supplysite_id: SuSi1.id, demandsite_id: DeSi4.id, unit_cost: 7, transport_quantity: 0.0)
    TraLi5 = Translink.create!(supplysite_id: SuSi2.id, demandsite_id: DeSi1.id, unit_cost: 4, transport_quantity: 0.0)
    TraLi6 = Translink.create!(supplysite_id: SuSi2.id, demandsite_id: DeSi2.id, unit_cost: 9, transport_quantity: 0.0)
    TraLi7 = Translink.create!(supplysite_id: SuSi2.id, demandsite_id: DeSi3.id, unit_cost: 5, transport_quantity: 0.0)
    TraLi8 = Translink.create!(supplysite_id: SuSi2.id, demandsite_id: DeSi4.id, unit_cost: 3, transport_quantity: 0.0)
    TraLi9 = Translink.create!(supplysite_id: SuSi3.id, demandsite_id: DeSi1.id, unit_cost: 8, transport_quantity: 0.0)
    TraLi10 = Translink.create!(supplysite_id: SuSi3.id, demandsite_id: DeSi2.id, unit_cost: 8, transport_quantity: 0.0)
    TraLi11 = Translink.create!(supplysite_id: SuSi3.id, demandsite_id: DeSi3.id, unit_cost: 1, transport_quantity: 0.0)
    TraLi12 = Translink.create!(supplysite_id: SuSi3.id, demandsite_id: DeSi4.id, unit_cost: 6, transport_quantity: 0.0)


    Prod1 = Product.create!(name: "P1", setup_time: 20, processing_time: 1,
                            setup_cost: 200, holding_cost: 40,
                            initial_inventory: 50, lead_time_periods: 1)

    Prod2 = Product.create!(name: "P2", setup_time: 30, processing_time: 1,
                            setup_cost: 500, holding_cost: 35,
                            initial_inventory: 120, lead_time_periods: 1)

    Prod3 = Product.create!(name: "P3", setup_time: 10, processing_time: 1,
                            setup_cost: 300, holding_cost: 15,
                            initial_inventory: 100, lead_time_periods: 1)

    Prod4 = Product.create!(name: "P4", setup_time: 20, processing_time: 1,
                            setup_cost: 1000, holding_cost: 4,
                            initial_inventory: 110, lead_time_periods: 1)

    Prod5 = Product.create!(name: "P5", setup_time: 10, processing_time: 1,
                            setup_cost: 300, holding_cost: 3,
                            initial_inventory: 80, lead_time_periods: 1)


    (1..4).each do |n|
      name = "#{n}"
      Period.create!(name: name)
    end

    (1..2).each do |n|
      name = "m#{n}"
      Machine.create!(name: name, overtime_cost: 200)
    end

    (1..2).each do |m|
      (1..4).each do |n|
        MachinePeriod.create!(machine_id: m, period_id: n, capacity: 150)
      end
    end

    P1t1 = ProductPeriod.create!(product_id: 1, period_id: 1, demand: 10)
    P1t2 = ProductPeriod.create!(product_id: 1, period_id: 2, demand: 20)
    P1t3 = ProductPeriod.create!(product_id: 1, period_id: 3, demand: 30)
    P1t4 = ProductPeriod.create!(product_id: 1, period_id: 4, demand: 80)

    P2t1 = ProductPeriod.create!(product_id: 2, period_id: 1, demand: 20)
    P2t2 = ProductPeriod.create!(product_id: 2, period_id: 2, demand: 80)
    P2t3 = ProductPeriod.create!(product_id: 2, period_id: 3, demand: 50)
    P2t4 = ProductPeriod.create!(product_id: 2, period_id: 4, demand: 90)

    P3t1 = ProductPeriod.create!(product_id: 3, period_id: 1, demand: 0)
    P3t2 = ProductPeriod.create!(product_id: 3, period_id: 2, demand: 0)
    P3t3 = ProductPeriod.create!(product_id: 3, period_id: 3, demand: 30)
    P3t4 = ProductPeriod.create!(product_id: 3, period_id: 4, demand: 0)

    P4t1 = ProductPeriod.create!(product_id: 4, period_id: 1, demand: 0)
    P4t2 = ProductPeriod.create!(product_id: 4, period_id: 2, demand: 0)
    P4t3 = ProductPeriod.create!(product_id: 4, period_id: 3, demand: 0)
    P4t4 = ProductPeriod.create!(product_id: 4, period_id: 4, demand: 80)

    P5t1 = ProductPeriod.create!(product_id: 5, period_id: 1, demand: 0)
    P5t2 = ProductPeriod.create!(product_id: 5, period_id: 2, demand: 0)
    P5t3 = ProductPeriod.create!(product_id: 5, period_id: 3, demand: 0)
    P5t4 = ProductPeriod.create!(product_id: 5, period_id: 4, demand: 0)

    P3P1 = ProductProduct.create!(from_product_id: 3, to_product_id:1, coefficient: 1 )
    P3P2 = ProductProduct.create!(from_product_id: 3, to_product_id:2, coefficient: 1 )
    P4P1 = ProductProduct.create!(from_product_id: 4, to_product_id:1, coefficient: 1 )
    P5P3 = ProductProduct.create!(from_product_id: 5, to_product_id:3, coefficient: 1 )
    P5P4 = ProductProduct.create!(from_product_id: 5, to_product_id:4, coefficient: 1 )

    P1M1 = ProductMachine.create!(product_id: 1, machine_id:1)
    P2M1 = ProductMachine.create!(product_id: 2, machine_id:1)
    P5M1 = ProductMachine.create!(product_id: 5, machine_id:1)
    P3M2 = ProductMachine.create!(product_id: 3, machine_id:2)
    P4M2 = ProductMachine.create!(product_id: 4, machine_id:2)
    
    #Werte fuer OP Planung
    #
    #Calculation Tabelle
    Calc1 = Calculation.create!(workhours_perDay: 8, user_id: User.first.id)
    #operating Room
    OPR1 = OperatingRoom.create!(name: "OP1", amount: 2)
    OPR2 = OperatingRoom.create!(name: "OP2", amount: 3)
    #Specialty
    SPEC1 = Specialty.create!(shortcode: "ORT", name: "Orthopeadic")
    SPEC2 = Specialty.create!(shortcode: "MOV", name: "Movement")
    SPEC3 = Specialty.create!(shortcode: "NEU", name: "Neuro")
    SPEC4 = Specialty.create!(shortcode: "ONC", name: "Oncology")
    #Patienten
        25.times do |n|
#      name = Faker::Name.name
      name = "Patient-Meyer-#{n+1}"
      age = 30
      city = "Hannover"
      type_of_patient = 1
      startday_of_stay = "Mon"
      op_time = 2
      Patient.create!(name: name,
                   age: age,
                   city: city,
                   type_of_patient: type_of_patient,
                   startday_of_stay: startday_of_stay,
                   op_time: op_time,
                   specialty_id: SPEC1.id)
    end
     15.times do |n|
      name = "Patient-Mueller-#{n+1}"
      age = 25
      city = "Hildesheim"
      type_of_patient = 2
      startday_of_stay = "Wed"
      op_time = 3
      Patient.create!(name: name,
                   age: age,
                   city: city,
                   type_of_patient: type_of_patient,
                   startday_of_stay: startday_of_stay,
                   op_time: op_time,
                   specialty_id: SPEC2.id)
    end
    
   7.times do |n|
      name = "Patient-Schroeder-#{n+1}"
      age = 35
      city = "Hamburg"
      type_of_patient = 0
      startday_of_stay = "Tue"
      op_time = 1
      Patient.create!(name: name,
                   age: age,
                   city: city,
                   type_of_patient: type_of_patient,
                   startday_of_stay: startday_of_stay,
                   op_time: op_time,
                   specialty_id: SPEC2.id)
    end 
   13.times do |n|
      name = "Patient-Schneider-#{n+1}"
      age = 50
      city = "Bremen"
      type_of_patient = 2
      startday_of_stay = "Thu"
      op_time = 4
      Patient.create!(name: name,
                   age: age,
                   city: city,
                   type_of_patient: type_of_patient,
                   startday_of_stay: startday_of_stay,
                   op_time: op_time,
                   specialty_id: SPEC3.id)
    end 
   
      17.times do |n|
      name = "Patient-Brase-#{n+1}"
      age = 45
      city = "Celle"
      type_of_patient = 1
      startday_of_stay = "Fri"
      op_time = 2
      Patient.create!(name: name,
                   age: age,
                   city: city,
                   type_of_patient: type_of_patient,
                   startday_of_stay: startday_of_stay,
                   op_time: op_time,
                   specialty_id: SPEC4.id)
    end 

    #room_specialty
    RoomSpecialty.create!(operating_room_id: OPR1.id, specialty_id: SPEC2.id)
    RoomSpecialty.create!(operating_room_id: OPR2.id, specialty_id: SPEC1.id)
    RoomSpecialty.create!(operating_room_id: OPR2.id, specialty_id: SPEC2.id)
    RoomSpecialty.create!(operating_room_id: OPR2.id, specialty_id: SPEC4.id)
    RoomSpecialty.create!(operating_room_id: OPR1.id, specialty_id: SPEC3.id)
  end
end