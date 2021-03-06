class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    if params[:tags]
      @notes = Note.by_tags(tag_params)
    else
      @notes = Note.order(created_at: :desc )
    end
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.create(content: '')

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(:notes, @note)
        end
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        Tag.sync(@note)

        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.content = ''
    Tag.sync(@note)
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@note))
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:content)
    end

    def tag_params
      params.require(:tags).permit(include: [], exclude: [])
    end
end
