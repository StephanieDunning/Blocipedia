class CollaboratorsController < ApplicationController
  # def index
  # end
  #
  # def new
  #   @collaborator = Collaborator.new
  #   @user = User.all
  #   @wiki = Wiki.find(params[:wiki_id])
  # end

  def create
    @wiki = Wiki.find(params[:collaborator][:wiki_id])
    @collaborator = @wiki.collaborators.build(user_id: params[:collaborator][:user_id])

    if @collaborator.save
      flash[:notice] = "A new collaborator has been added to your wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error adding this collaborator. Please try again."
      render :new
    end
  end

  # def show
  #   @collaborator = Collaborator.find(params[:wiki])
  # end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "Collaborator has been removed from this wiki."
    else
      flash[:error] = "There was an error removing this collaborator."
    end
    redirect_to edit_wiki_path(wiki)
  end
end
