remove = $('#<%="story_#{@story_like.story_id}"%>')
parent = $(remove).closest('td')
$(remove).remove()
parent.children('.voted').addClass("hoffset3")
