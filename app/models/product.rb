class Product
  attr_accessor :id, :name

  @@products = [] 

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.find(id)
    @@products.find {|product| product[:id] == id.to_i }
  end

  def self.all
    @@products
  end

  def self.create(name)
    sleep 5
    product = {id: last_product_id + 1, name: name}

      @@products[last_product_id] = product 

    return product
  end 

  def self.create_multiple(quantity)
    quantity.times do |id|
      product = new(self.last_product_id + id, name) 
      @@products << product
    end
  end

  def self.last_product_id
    @last_product_id = @@products.any? ? @@products.last[:id] : 0 
  end
end
