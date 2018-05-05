class Dog
  attr_accessor :name, :breed, :id

  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end

  def self::create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      album TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end

  def self::drop_table
    sql = <<-SQL
    DROP TABLE IF EXISTS dogs
    SQL
    DB[:conn].execute(sql)[0]
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end

  def self::create(name:, breed:)
    @name = name
    @breed = breed
    dog = Dog.new(name: @name, breed: @breed)
    dog.save
    dog
  end

  def self::find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql)[0]
    Dog.new(result[1], result[2], result[3])
    dog
  end

  def self::find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND
    breed = ?", name, breed)
      if !dog.empty?
        dog_data = dog[0]
        dog = Dog.new(dog_data[0], dog_data[1], dog_data[2])
      else
        dog = self.create(name: name, breed: breed)
      end
      dog
    end

  def self::find_by_name
    sql = <<-SQL
      SELECT * FROM dogs WHERE name = ? LIMIT 1
    SQL
    DB[:conn].execute(sql, name) [0]
    new_dog = dog.new(result[0], result[1], result[2])
    end

    def sef::new_from_db

    end

  def update
    sql = "UPDATE dogs SET name = ?, breed = ?, WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)

  end


end
