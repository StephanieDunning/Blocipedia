class WikisController < ApplicationController
  # before_action :authorize_user, only: [:destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @user = current_user
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @collaborator = Collaborator.new
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
    collab_users = @wiki.users
    @users = User.where.not(id: current_user.id).map{|u| [u.email, u.id] unless collab_users.include?(u)}.compact
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  # def authorize_user
  #   @wiki = Wiki.find(params[:id])
  #   unless current_user == @wiki.user || current_user.admin?
  #     flash[:alert] = "You must be an admin to do that."
  #     redirect_to @wiki
  #   end
  # end
end
