class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def show
	end

	def new
		@recipe = current_user.recipes.build
		@recipe.ingredients.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)
		@recipe.ingredients.build
		if @recipe.save
			redirect_to @recipe, notice: "Successfuly created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
			redirect_to root_path, notice: "Sucessfully deleted recipe"
	end

	private

	def recipe_params

		params.require(:recipe)
			.permit(
				:title,
				:description,
				:image,
				ingredients_attributes: [:id, :name, :_destroy],
				directions_attributes: [:id, :step, :_destroy]
			)
	end
	
	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

	def correct_user
		@recipe = current_user.recipes.find_by(id: params[:id])
#			if @recipe.nil?
#				redirect_to_root_path, notice: "Not authorized"
#			end
	end
end
