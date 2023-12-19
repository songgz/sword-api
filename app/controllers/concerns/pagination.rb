# frozen_string_literal: true
module Pagination
  extend ActiveSupport::Concern

  included do
    helper_method :pagination
  end

  def pagination(records)
    {
      total_count: records&.total_count || 0,
      page_size: records&.limit_value || 0,
      page_count: records&.total_pages || 0,
      page_no: records&.current_page || 0
    }
  end



  def paginate(records)
    records.page(params[:page]).per(params[:pre])
  end

end
