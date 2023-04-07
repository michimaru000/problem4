class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  def new
    @book = Book.new
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @book = Book.new
    
    @book_id = Book.find(params[:id])  
    @user = @book_id.user
  end
  
  def edit
    
    @book = Book.find(params[:id])
    user = @book.user
    unless user.id == current_user.id
      redirect_to "/books"
    end
   
  end
  
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
       redirect_to book_path(@book.id),notice:'create successfully'
    else
      render :index
    end
  end
  
  def update
    @book = Book.find(params[:id])
    user = @book.user
    unless user.id == current_user.id
      redirect_to "/books"
    end
  
    @user = current_user
    @books = Book.all
    if @book.update(book_params)
       redirect_to book_path(@book.id),notice:'book update successfully'
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
