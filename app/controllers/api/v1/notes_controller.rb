class Api::V1::NotesController < ApplicationController
  before_action :set_company, only: [:create, :update, :destroy]

  def index
    render json: current_user.notes, status: 200
  end

  def create
    note = Note.new(note_params)
    note.author = current_user.username
    note.user = current_user
    note.company = @company
    if note.save
      render json: note, status: 201
    else
      render json: {message: "Failed to create a note"}, status: 400
    end
  end

  def update
    note = @company.notes.find(params[:id])
    if note.update(note_params)
      render json: note, status: 200
    else
      render json: {message: "Failed to update a note"}, status: 400
    end
  end

  def destroy
    note = @company.notes.find(params[:id])
    note.destroy
    render json: {message: "Successfully deleted."}, status: 200
  end

  private
    def note_params
      params.require(:note).permit(:title, :body)
    end

    def set_company
     @company = Company.find_by(name: params[:company_name])
    end
end
