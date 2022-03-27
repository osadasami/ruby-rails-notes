class Tag < ApplicationRecord
	has_and_belongs_to_many :notes

	def self.sync(note)
		# Найти или создать новые теги
		tag_names = note.content.scan(/#.*?#/)
		new_tags = []

		tag_names.each do |tag_name|
			new_tags.push(Tag.find_or_create_by(name: tag_name))
		end

		# получить старые теги
		old_tags = note.tags - new_tags

		# отцепить все теги
		note.tags.delete_all

		# прицепить новые тиг
		note.tags.concat(new_tags)

		# удалить старые теги если они не сцеплины ни с одной заметкой 
		old_tags.each do |old_tag|
			old_tag.destroy if old_tag.notes.empty?
		end
	end
end
