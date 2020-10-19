require 'csv'
class Gossip                       # Classe Gossip
  attr_accessor :content, :author
  def initialize(author, content)  
    @author = author
    @content = content
  end
   
  def save                          # Methode de sauvegarde des gossips
    CSV.open('./db/gossip.csv', 'a+') do |csv|   # Ouvre le CSV et integre un objet contenat les 2 variables
    csv << [@author, @content]
    end
  end

  def self.all                      # Methode pour afficher l'integralité des Gossips
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|          
      all_gossips << Gossip.new(csv_line[0], csv_line[1])    # Creé une nouvelle array, et la remplis avec les objets du CSV
    end                                                      # Et le return
      return all_gossips
    end

  def self.find(id)                        # Methode pour trouver des Gossip selon leurs ID
    all_gossips = []                       # afin de les affiché dans le Show individuellement
    csv = CSV.read('./db/gossip.csv').each do |gossip|
      temp_gossip  = Gossip.new(gossip[0], gossip[1])
      all_gossips << temp_gossip
    end
    return all_gossips[id.to_i]            # meme systeme que le self.all, mais selectionne uniquement le gossip ayant l'id correspondant a l'id demander
  end

    
    
  def self.update(new_author, new_content, id)      # Methode pour modifié un Gossip
    rows_array = Array.new                               # on crée une nouvelle array
    CSV.read('./db/gossip.csv').each do |csv_line|               # on y integre le contenus du CSV
      rows_array << Gossip.new(csv_line[0], csv_line[1])
    end 
    gossip = rows_array[id]                          # On selectionne le Gossip ayant l'id voulu dans l'array nouvellement crée
    gossip.author = new_author                       # On modifie l'auteur
    gossip.content = new_content                      # On modifie le contenu
    rows_array[id] = gossip                             # on reintegre le gossip dans l'array
      CSV.open('./db/gossip.csv', 'w') do |csv|            
        rows_array.each do |gossip|                       # on reecrit le CSV entierement avec les nouveaux Gossips
      csv << [gossip.author, gossip.content]
      end
    end
  end
end