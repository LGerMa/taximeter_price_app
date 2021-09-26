class TaximetersController < ApplicationController
  before_action :set_company

  def index
    @taximeters = @company.taximeters
  end

  def show
    set_taximeter
  end

  def new
    @taximeter = @company.taximeters.new
  end

  def edit
    set_taximeter
  end

  def create
    @taximeter = @company.taximeters.new(taximeter_params)

    respond_to do |format|
      if @taximeter.save
        format.html { redirect_to company_taximeters_path(@company), notice: "Taximeter was successfully created." }
        format.json { render :show, status: :created, location: @taximeter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @taximeter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if set_taximeter.update(taximeter_params)
        format.html { redirect_to company_taximeters_path(@company), notice: "Taximeter was successfully updated." }
        #format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_taximeter
      @taximeter = @company.taximeters.find(params[:id])
    end

    def taximeter_params
      tp = params.require(:taximeter).permit(:start_price, :km_price, :minute_price, :minimum_price, :time_from,
                                             :time_to, :days => [])
      tp[:days] = tp[:days].join(',') if tp[:days].present?
      tp
    end
end
