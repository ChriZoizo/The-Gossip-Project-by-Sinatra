require 'csv'
class Gossip                       # Classe Gossip
  attr_accessor :content, :author
  def initialize(author, content)  
    @author = author
    @content = content
  end
   
  def save                          # Methode de sauvegarde des gossips
    CSV.open('./db/gossip.csv', 'a+') do |csv|
    csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end 
      return all_gossips
    end

  def self.find(id) 
    all_gossips = []
    csv = CSV.read('./db/gossip.csv').each do |gossip|
      temp_gossip  = Gossip.new(gossip[0], gossip[1])
      all_gossips << temp_gossip
    end
    return all_gossips[id.to_i]   #FUCK YEAHHHHHH!
  end

    
    
  def self.update(new_author, new_content, id)
    rows_array = Array.new
    CSV.read('./db/gossip.csv').each do |csv_line|
      rows_array << Gossip.new(csv_line[0], csv_line[1])
    end
    gossip = rows_array[id]
    gossip.author = new_author
    gossip.content = new_content
    rows_array[id] = gossip
      CSV.open('./db/gossip.csv', 'w') do |csv|
        rows_array.each do |gossip|
      csv << [gossip.author, gossip.content]
      end
    end
  end
end