remove = $('#<%="comment_#{@comment_like.comment_id}"%>')
parent = $(remove).closest('td')
$(remove).remove()
parent.children('.near_like').addClass("hoffset3")
