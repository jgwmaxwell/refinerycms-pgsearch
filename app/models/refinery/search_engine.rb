module Refinery
  class SearchEngine

    # How many results should we show per page
    RESULTS_LIMIT = 10

    # Perform search over the specified models
    def self.search(query, page = 1)
      PgSearch.multisearch(query).paginate(:page => page, :per_page => RESULTS_LIMIT)
    end

  end
end
