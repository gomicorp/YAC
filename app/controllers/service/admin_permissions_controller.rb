module Service
  class AdminPermissionsController < BaseController
    before_action :set_organization
    before_action :set_admin_permission, only: %i[show edit update destroy]

    # GET /organizations/1/admins
    # GET /organizations/1/admins.json
    def index
      @admin_permissions = admin_permissions.all
    end

    # GET /organizations/1/admins/1
    # GET /organizations/1/admins/1.json
    def show
    end

    # GET /organizations/1/admins/new
    def new
      @admin_permission = admin_permissions.new
    end

    # GET /organizations/1/admins/1/edit
    def edit
    end

    # POST /organizations/1/admins
    # POST /organizations/1/admins.json
    def create
      @admin_permission = admin_permissions.new(admin_permission_params)

      respond_to do |format|
        if @admin_permission.save
          format.html { redirect_to after_create_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @admin_permission }
        else
          format.html { render :new }
          format.json { render json: @admin_permission.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /organizations/1/admins/1
    # PATCH/PUT /organizations/1/admins/1.json
    def update
      respond_to do |format|
        if @admin_permission.update(admin_permission_params)
          format.html { redirect_to after_update_path, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_permission }
        else
          format.html { render :edit }
          format.json { render json: @admin_permission.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /organizations/1/admins/1
    # DELETE /organizations/1/admins/1.json
    def destroy
      @admin_permission.destroy
      respond_to do |format|
        format.html { redirect_to after_destroy_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


    private

    def set_organization
      @organization = Organization.find(params[:organization_id])
      @site = @organization.sites.first
      @admins = @organization.admins.includes(:admin_permissions)
    end

    def admin_permissions
      @organization.admin_permissions.includes(:admin)
    end

    def set_admin_permission
      @admin_permission = admin_permissions.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_permission_params
      params.require(:organization_admin_permission).permit(:admin_id)
    end

    def after_default_path
      organization_admin_permissions_path(@organization.id)
    end

    def default_collection_path
      organization_admin_permissions_path(@organization.id)
    end

    alias after_create_path after_default_path
    alias after_update_path after_default_path
    alias after_destroy_path default_collection_path
  end
end
