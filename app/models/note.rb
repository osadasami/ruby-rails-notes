class Note < ApplicationRecord
	has_and_belongs_to_many :tags

	def html
		CommonMarker::Rouge.render_html(self.content).html_safe
	end
end
