class V1::BaseController < ApplicationController
  include Rails::Pagination

    WillPaginate.per_page = 32

  private
  def meta_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page, # use collection.previous_page when using will_paginate
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }.merge(extra_meta)
  end
end
