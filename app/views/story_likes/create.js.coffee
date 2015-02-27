remove = $('#<%="story_#{@story_like.story_id}"%>')
parent = $(remove).closest('td')
$(remove).remove()
parent.children('.near_like').addClass("hoffset3")
