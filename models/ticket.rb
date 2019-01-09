require('pg')

class Ticket

  attr_accessor :title, :date, :time, :seat
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @date = options['date']
    @time = options['time']
    @seat = options['seat']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql =
      "INSERT INTO tickets (
        title,
        date,
        time,
        seat
        )
        VALUES ($1, $2, $3, $4)
        RETURNING *"
      values = [@title, @date, @time, @seat]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]["id"].to_i
      db.close()
  end

  def Ticket.all()
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql = "SELECT * FROM tickets"
    db.prepare("all", sql)
    bookings = db.exec_prepared("all")
    db.close()
    return bookings.map {|booking| Ticket.new(booking)}
  end

  def Ticket.delete_all()
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql = "DELETE FROM tickets"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql =
      "DELETE FROM tickets
      WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql =
      "UPDATE tickets
      SET (
        title,
        date,
        time,
        seat)
      = (
        $1, $2, $3, $4)
        WHERE id = $5"
    values = [@title, @date, @time, @seat, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Ticket.find_by_name(title)
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql =
      "SELECT * FROM tickets
      WHERE title = '#{title}'"
      db.prepare("find_by_name", sql)
      result = db.exec_prepared("find_by_name")
      db.close()
      if result.count == 0
        return nil
      else
        return Ticket.new(result[0])
      end
  end

  def Ticket.find_by_id(id)
    db = PG.connect({dbname: 'tickets', host: 'localhost'})
    sql =
      "SELECT * FROM tickets
      WHERE id = #{id}"
      db.prepare("find_by_id", sql)
      result = db.exec_prepared("find_by_id")
      db.close()
      if result.count == 0
        return nil
      else
        return Ticket.new(result[0])
      end
    end


end
