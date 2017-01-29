require 'wikipedia'

class WikipediaFinder 

  def page_url(search_term)
    return "" if search_term.nil?
    Wikipedia.find(search_term).fullurl
  end

end