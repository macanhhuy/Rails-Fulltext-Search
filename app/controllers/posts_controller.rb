class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def search
			@search = Post.search() do
				keywords(params[:q].gsub('%20', ' '))
			end
	end
	# GET /posts
	# GET /posts.json
	def index
		@posts = Post.all
	end

	# GET /posts/1
	# GET /posts/1.json
	def show
		@post = Post.find(params[:id])
		# @post = Post.friendly.find(params[:id])
		redirect_to(root_url, :notice => 'Record not found') unless @post
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @post }
		end
	end

	# GET /posts/new
	def new
		@post = Post.new
	end

	# GET /posts/1/edit
	def edit
	end

	# POST /posts
	# POST /posts.json
	def create
		@post = Post.new(post_params)

		respond_to do |format|
			if @post.save
				format.html { redirect_to @post, notice: 'Post was successfully created.' }
				format.json { render :show, status: :created, location: @post }
			else
				format.html { render :new }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /posts/1
	# PATCH/PUT /posts/1.json
	def update
		respond_to do |format|
			if @post.update(post_params)
				format.html { redirect_to @post, notice: 'Post was successfully updated.' }
				format.json { render :show, status: :ok, location: @post }
			else
				format.html { render :edit }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /posts/1
	# DELETE /posts/1.json
	def destroy
		@post.destroy
		respond_to do |format|
			format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_post
			@post = Post.find(params[:id])
			rescue ActiveRecord::RecordNotFound
				redirect_to root_url, notice: 'Record not found'

		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def post_params
			params.require(:post).permit(:title, :content, :image)
		end
end
