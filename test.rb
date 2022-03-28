tags = [
	'#person/Димасик#',
	'#person/Багдасик#',
	'#type/book#',
	'#type/movie#',
	'#type/anime#',
	'#rating/🟢#',
	'#rating/🟡#',
	'#rating/🔴#',
	'#area/соционика/аспекты/чл#',
	'#area/соционика/аспекты/бл#',
	'#area/соционика/аспекты/чс#',
	'#area/соционика/аспекты/бл#',
	'#area/соционика/аспекты/чэ#',
	'#area/соционика/аспекты/бэ#',
]

def build_tree(tag, item)
	name, tag = tag.gsub('#', '').split('/', 2)

	item[name]||= {}
	item[name] = nil unless tag

	if tag
		build_tree(tag, item[name])
	end
end

tree = {}

tags.each do |tag|
	build_tree(tag, tree)
end

# build_tree('#qwe/asd/zxc/123#', tree)
# build_tree('#qwe/asd/zxc/234#', tree)
# build_tree('#qwe/wer/zxc/234#', tree)

pp tree

# qwe/asd
# qwe/zxc/123
# =>
# {
# 	'qwe': {
# 		'asd': nil,
# 		'zxc': {
# 			'123': nil
# 		}
# 	}
# }
