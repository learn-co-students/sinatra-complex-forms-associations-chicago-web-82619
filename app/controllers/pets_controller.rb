class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])
    @owner = Owner.find_by(id: params[:pet][:owner_id])
    # binding.pry
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @owner.pets << @pet
    else
      @owner.pets << @pet
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    # binding.pry
    erb :"pets/edit"
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    # binding.pry
    @pet.name = params[:pet_name]
    @owner = Owner.find(params[:owner][:id])
    @pet.owner = @owner
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
