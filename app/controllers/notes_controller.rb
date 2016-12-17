class NotesController < ApplicationController
  def create
    company = Company.find(params[:company_id])
    note = company.notes.new(note_params)
    note.user_id = current_user.id

    if note.save
      flash[:success] = 'Your note has been added!'
    else
    end
    redirect_to request.referrer
  end

  def edit
    @company = Company.find(params[:company_id])
    @note = @company.notes.find(params[:id])
  end

  def update
    company = Company.find(params[:company_id])
    note = company.notes.find(params[:id])
    note.update(note_params)
    flash[:success] = "Note has been edited."
    redirect_to company_path(company)
  end

  def destroy
    company = Company.find(params[:company_id])
    note = company.notes.find(params[:note_id])
    note.destroy
    flash[:success] = "Comment has been removed"
    redirect_to company_path(company)
  end

  private
    def note_params
      params.require(:note).permit(:title, :body)
    end
end
