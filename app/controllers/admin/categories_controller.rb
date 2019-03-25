class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index; redirect_to :action => 'new' ; end
  def edit; new_or_edit;  end

  def new 
    respond_to do |format|
      format.html { new_or_edit }
      format.js { 
        @category = Category.new
      }
    end
  end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  private

  def new_or_edit
    @categories = Category.find(:all)
    # bug fix 1. Doesn't break if the params[:id] is nil
    if params[:id].nil?
      @category = Category.new
    else
      @category = Category.find(params[:id])
    end
    @category.attributes = params[:category]
    if request.post?
      respond_to do |format|
        format.html { save_category }
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
      return
    end
    render 'new'
  end

  def save_category
    # bug fix 2.
    # There was also the issue when it came to saving a category on the site
    # The problem was with the code in this function that made incorrect
    # calls to certain functions causing syntax errors.
    if !(@category.save)
      flash[:notice] = _('Category was successfully saved.')
    else
      @category.save!
      flash[:error] = _('Category could not be saved.')
    end
    redirect_to :action => 'new'
  end

end
