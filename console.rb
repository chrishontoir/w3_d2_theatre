require('pry')
require_relative('models/ticket.rb')

Ticket.delete_all()

ticket1 = Ticket.new(
  {
    'title' => 'Oliver!',
    'date' => '08/01/2019',
    'time' => '14:30',
    'seat' => 'RC-A15'
  }
)

ticket2 = Ticket.new(
  {
    'title' => 'Wicked',
    'date' => '09/01/2019',
    'time' => '19:30',
    'seat' => 'S-G25'
  }
)

ticket1.save()
ticket2.save()

# ticket1.find_by_name("Wicked")

ticket1.title = "The Wizard of Oz"

binding.pry
nil
