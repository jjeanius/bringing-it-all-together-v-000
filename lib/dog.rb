class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def initialize(id:'nil', name:, breed:)
    @id = nil
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
    sql = <<-SQL
    SELECT * FROM dogs WHERE id = ?
    SQL
    result = DB[:conn].execute(sql,id)[0]
    new_dog = dog.new(result[0], result[1], result[2])
    New_dog
  end

  def self::find_by_name
    sql = <<-SQL
      SELECT * FROM dogs WHERE name = ? LIMIT 1
    SQL
    DB[:conn].execute(sql, name) [0]
    new_dog = dog.new(result[0], result[1], result[2])
    end

  def update

  end


end
