module ApplicationHelper
	def tag_link(name, path)
		included_tags = params.dig(:tags, :include).clone || []
		excluded_tags = params.dig(:tags, :exclude).clone || []

		default_classes = 'text-gray-500 hover:text-green-500'
		included_classes = 'text-green-500 hover:text-red-500'
		excluded_classes = 'text-red-500 hover:text-gray-500'
		classes = ''

		if !included_tags.include?(path) && !excluded_tags.include?(path)
			included_tags.push(path)
			classes = default_classes
		elsif included_tags.include?(path) && !excluded_tags.include?(path)
			included_tags.delete(path)
			excluded_tags.push(path)
			classes = included_classes
		elsif !included_tags.include?(path) && excluded_tags.include?(path)
			excluded_tags.delete(path)
			classes = excluded_classes
		end

		link_to name, root_path(tags: {include: included_tags, exclude: excluded_tags}), class: classes
	end
end
