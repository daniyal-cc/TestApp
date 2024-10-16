class PortfoliosController < ApplicationController

  layout 'portfolio'
  
    def index
        @portfolio_items = Portfolio.all
        @page_title = "My Portfolio"
    end

    def new 
        @portfolio_item = Portfolio.new
    end

    def create
        @portfolio_item = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body))
    
        respond_to do |format|
          if @portfolio_item.save
            format.html { redirect_to portfolios_path, notice: "Blog was successfully created." }
            format.json { render :show, status: :created, location: @portfolio }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @portfolio.errors, status: :unprocessable_entity }
          end
        end
    end

    def edit
        @portfolio_item = Portfolio.find(params[:id])
    end

    def update
        @portfolio_item = Portfolio.find(params[:id])

        respond_to do |format|
          if @portfolio_item.update(params.require(:portfolio).permit(:title, :subtitle, :body))
            format.html { redirect_to portfolios_path, notice: "Record was successfully updated." }
            format.json { render :show, status: :ok, location: @portfolio }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @portfolio.errors, status: :unprocessable_entity }
          end
        end
    end

    def show
        @portfolio_item = Portfolio.find(params[:id])
        @page_title = @portfolio_item.title
    end

    def destroy
        # Perform teh lookup
        @portfolio_item = Portfolio.find(params[:id])

        # Destroty the record 
        @portfolio_item.destroy
    
        # Redirect
        respond_to do |format|
          format.html { redirect_to portfolios_path, notice: "Record was successfully destroyed." }
          format.json { head :no_content }
        end
    end

end
