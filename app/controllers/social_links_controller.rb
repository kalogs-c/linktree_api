class SocialLinksController < ApplicationController
before_action :set_social_link, only: %i[ update destroy ]
  before_action :require_authentication
  allow_unauthenticated_access only: :show

  # GET /social_links
  def index
    render json: Current.user.social_links
  end

  # GET /social_links/:username
    def show
      username = params.require(:username)
      user = User.find_by(username: username)
    
      if user
        user_social_links = user.social_links
        render json: {
          nome: user.name,
          email: user.email_address,
          social_links: user_social_links
        }
      else
        render json: { error: "User not found" }, status: :not_found
      end
    end
    

  # POST /social_links
  def create
    current_user_id = Current.user.id
    attrs = social_link_params.merge(user_id: current_user_id)
    @social_link = SocialLink.new(attrs)

    if @social_link.save
      render json: @social_link, status: :created, location: @social_link
    else
      render json: @social_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /social_links/1
  def update
    if @social_link.update(social_link_params)
      render json: @social_link
    else
      render json: @social_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /social_links/1
  def destroy
    @social_link.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_social_link
    @social_link = SocialLink.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def social_link_params
    params.expect(social_link: [ :url, :description, :user_id ])
  end
end
