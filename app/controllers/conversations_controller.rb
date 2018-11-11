class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :destroy]
  before_action :check_current_user, only: [:show, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = current_user.conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end


  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.fetch(:conversation, {})
    end

    def check_current_user
      unless @conversation.users.include?(current_user)
        # TODO change message
        redirect_to :root, alert: "YOU CANT VIEW THIS DICK!!!!!"
      end
    end
end
