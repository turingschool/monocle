class NotesController < ApplicationController
  def create
    company = Company.find(params[:company_id])
    note = company.notes.create(note_params)
    note.user_id = current_user.id
    note.author = current_user.username
    require 'pry'; binding.pry
    render json: note
  end

  def edit
    @company = Company.find(params[:company_id])
    @note = @company.notes.find(params[:id])
  end

  def update
    company = Company.find(params[:company_id])
    note = company.notes.find(params[:id])
    note.update(note_params)
    render json: note
  end

  def destroy
    company = Company.find(params[:company_id])
    note = company.notes.find(params[:id])
    note.destroy
  end

  private
    def note_params
      params.require(:note).permit(:title, :body, :user_id, :company_id)
    end
end
