class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :authenticate_user!
  
  
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    authorize @articles
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    authorize @article
  end

  # GET /articles/new
  def new
    flash[:notice] = 'Se você efetou o pagamento e não foi confirmado, por favor entre em contato!'
    begin
      if user_signed_in? && (!current_user.admin?)
          if current_user.pay?
                  flash[:notice] =  "Seu pagamento foi confirmado! Obg..."
          else
          # Função critica do sistema! Testar antes de colocar em produção
            current_user.verify_pay
            if current_user.error_pay?
              flash[:error] =  "Por favor contate os administradores do SINFO!"
            end
          end
    end
    rescue 
      flash[:alert] = 'Houve um erro de comunicação com o pagseguro, por favor aguarde...'
    end 
    
    @article = Article.new
    @article.user = @user
  end

  # GET /articles/1/edit
  def edit
    authorize @article
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = @user
    respond_to do |format|
      if @article.save
        format.html { redirect_to new_article_path, notice: 'Artigo enviado com sucesso' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize @article
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize @article
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_user
      @user = current_user
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:file_article, :user_id)
    end
end
