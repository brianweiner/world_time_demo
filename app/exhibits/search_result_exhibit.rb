require "timezone"

class SearchResultExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object, context)
    object.class.name == 'SearchResult'
  end

  def dst_icon(view_context)
    view_context.render "search_results/dst_icon" if timezone.dst?(current_time)
  end

  def local_time
    timezone.time_with_offset(current_time).strftime("%b %e, %Y %l:%M%P")
  end

  def city_link(view_context)
    city ? view_context.link_to(city, city_wiki_url, :target => "_blank") : "No City"
  end

  def state_link(view_context)
    state ? view_context.link_to(state, state_wiki_url, :target => "_blank") : "No State"
  end

  def country_link(view_context)
    country ? view_context.link_to(country, country_wiki_url, :target => "_blank") : "No Country"
  end

  def search_term_link(view_context)
    view_context.link_to(search_term, search_term_wiki_url, :target => "_blank")
  end

  def timezone_name
    timezone.name.gsub('_',' ')
  end

  private

  def current_time
    @current_time ||= Time.now
  end
  
  def timezone
    @timezone ||= Timezone.lookup(latitude, longitude)
  end
end