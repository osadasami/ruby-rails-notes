class Note < ApplicationRecord
	def md
		CommonMarker::Rouge.render_html(self.content, [:UNSAFE]).html_safe
	end
end
