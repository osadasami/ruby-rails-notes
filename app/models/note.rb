class Note < ApplicationRecord
  has_and_belongs_to_many :tags

  def html
    CommonMarker::Rouge.render_doc(self.content, :DEFAULT, [:autolink]).to_html.html_safe
  end

  def self.by_tags(tags)
    query = self

    filters = {
      include: -> (scope, tag) { scope.where('content LIKE ?', "%#{tag}%") },
      exclude: -> (scope, tag) { scope.where.not('content LIKE ?', "%#{tag}%") },
    }

    filters.each_pair do |key, filter|
      tags[key]&.each { |tag| query = filter.call(query, tag) }
    end

    query
      .order(created_at: :desc )
  end
end
