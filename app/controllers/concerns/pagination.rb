# frozen_string_literal: true
module Pagination
  extend ActiveSupport::Concern

  included do
    helper_method :pagination
  end

  def pagination(records)
    {
      total_count: records.total_count,
      page_size: records.limit_value,
      page_count: records.total_pages,
      page_no: records.current_page
    }
  end



  def paginate(records)
    records.page(params[:page]).per(params[:pre])
  end

end
