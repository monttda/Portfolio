remove = $('#<%="comment_#{@comment_like.comment_id}"%>')
parent = $(remove).closest('td')
$(remove).remove()
parent.children('.voted').addClass("hoffset3")
