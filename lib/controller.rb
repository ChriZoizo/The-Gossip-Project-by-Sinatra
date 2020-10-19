require 'bundler'
Bundler.require
require_relative 'gossip'

class ApplicationController < Sinatra::Base
  # affichage de l'index
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # Route pour afficher la page de creation de potins
  get '/gossips/new/' do    
    erb :new_gossip
  end
  # Route pour envoyer le formulaire de creation
  post '/gossips/new/' do 
    Gossip.new("#{params["gossip_author"]}"," #{params["gossip_content"]}").save
    redirect '/'
  end
  # Route pour afficher la fiche d'un seul potin
  get '/gossips/:id' do
  erb :show, locals: {id: params["id"], gossip: Gossip.find(params["id"])}
  end
  # Rout pour afficher la page d'edition des potins
  get '/gossips/:id/edit/' do
  erb :edit, locals: {id: params["id"]}
  end
  # Route pour envoyer le formulaire d'edition 
  post '/gossips/:id/edit/' do
    Gossip.update(params["gossip_author"], params["gossip_content"], params["id"].to_i)  
  redirect "/gossips/#{params["id"]}"
  end
end

