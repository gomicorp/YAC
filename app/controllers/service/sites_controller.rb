module Service
  class SitesController < BaseController
    before_action :set_organization
    before_action :set_site, only: %i[show edit update destroy]

    # GET /organizations/1/sites
    # GET /organizations/1/sites.json
    def index
      @sites = @organization.sites.order(id: :desc).all
    end

    # GET /organizations/1/sites/1
    # GET /organizations/1/sites/1.json
    def show
      redirect_to site_comments_path(@site.id)
    end

    # GET /organizations/1/sites/new
    def new
      @site = @organization.sites.new
    end

    # GET /organizations/1/sites/1/edit
    def edit
    end

    # POST /organizations/1/sites
    # POST /organizations/1/sites.json
    def create
      @site = @organization.sites.new(site_params)

      respond_to do |format|
        if @site.save
          format.html { redirect_to after_create_path, notice: 'Site was successfully created.' }
          format.json { render :show, status: :created, location: @site }
        else
          format.html { render :new }
          format.json { render json: @site.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /organizations/1/sites/1
    # PATCH/PUT /organizations/1/sites/1.json
    def update
      respond_to do |format|
        if @site.update(site_params)
          format.html { redirect_to after_update_path, notice: 'Site was successfully updated.' }
          format.json { render :show, status: :ok, location: @site }
        else
          format.html { render :edit }
          format.json { render json: @site.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /organizations/1/sites/1
    # DELETE /organizations/1/sites/1.json
    def destroy
      @site.destroy
      respond_to do |format|
        format.html { redirect_to service_sites_url, notice: 'Site was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


    private

    def set_organization
      @organization = Organization.find(params[:organization_id])
      @site = @organization.sites.first
    end

    def set_site
      @site = Site.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def site_params
      params.require(:site).permit(:domain, :name, :organization_id)
    end

    def after_create_path
      organization_site_path(@organization.id, @site)
    end

    def after_update_path
      organization_site_path(@organization.id, @site)
    end
  end
end
