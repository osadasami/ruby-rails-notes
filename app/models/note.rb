class Note < ApplicationRecord
	def md
		CommonMarker::Rouge.render_html(self.content).html_safe
	end
end
