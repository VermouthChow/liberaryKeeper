class CheckOutRecordsController < ApplicationController
  before_action :check_params_status!, only: :index

  def index
    @records = records.page(page).per_page(per)
  end

  private

  def records
    @records_result ||= CheckOutRecord::QueryCommand.call(params).result
  end

  def check_params_status!
    if params[:status] && CheckOutRecord.statuses.keys.exclude?(params[:status])
      raise ArgumentError, "Unexpected parameter status: #{ params[:status] }"
    end
  end
end
