class TransitionRecordsController < ApplicationController
  before_action :check_transition_type!, only: :index

  def index
    @records = records.page(page).per_page(per)
    @total_income_amount = records.sum(:amount)
  end

  private

  def records
    @records_result ||= TransitionRecord::QueryCommand.call(params).result
  end

  def check_transition_type!
    if params[:transition_type] && TransitionRecord.transition_types.keys.exclude?(params[:transition_type])
      raise ArgumentError, "Unexpected parameter transition_type: #{ params[:transition_type] }"
    end
  end
end
