var moderators = {
	init: function(){
		var self = this;
		$('#users_list_view, #moderators_list_view').selectable();
		$('#to_moderator, #to_user').click(function () {
			var list_view = $(this).attr('id') == "to_moderator" ? "#users_list_view" : "#moderators_list_view";
			var transfer_users = self.getSelectedUsersFromListView(list_view);
			if (transfer_users.length > 0) {
				self.removeSelectedUsersFromListView(list_view);

				$('#moderatorzy .button').hide();
				$('.loader').show();

				var post_data = { "users[]": transfer_users };
				if ($(this).attr('id') == "to_user") { post_data["_method"] = "delete" }

				$.ajax({
					url: $(this).attr('href'),
					dataType: "script",
					type: "post",
					data: post_data,
					complete: function(){
						$('#moderatorzy .button').show();
						$('.loader').hide();
					},
				});
			}
			return false;
		})
	},
	
	getSelectedUsersFromListView: function(list_view_id){
		var ids = [];
		$(list_view_id).find('.ui-selected').each(function () {
			ids.push($(this).attr('id').replace('user_', ''));
		});
		
		return ids;
	},
	
	removeSelectedUsersFromListView: function(list_view_id){
		$(list_view_id).find('.ui-selected').remove();
	},

}

$(document).ready(function () { moderators.init(); });