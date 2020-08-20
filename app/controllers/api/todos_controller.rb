class Api::TodosController < ApplicationController
  before_action :find_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.all

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    params = post_params
    params["completed"] = false
    @todo = Todo.new(params)

    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update

    if @todo.update(update_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.delete
    render json: "todo deleted", status: 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_todo
      if Todo.exists?(params[:id])
        @todo = Todo.find(params[:id])
      else
        render json: { erros:"can't find record with provided id"}, status: 422
      end
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      @post_params ||= params.require(:todo).permit(:title, :content)
    end

    def update_params
      @update_params ||= params.require(:todo).permit(:title, :content, :completed)
    end
end
