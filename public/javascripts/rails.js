$(document).ajaxSend(function(event, request, settings) { 
	if (typeof(window._token) == "undefined") return;
	
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window._token);
});

$.fn.extend({
	act_as_tabs: function() {
		$(this).click(function () {
			var tabs = $(this).parents('ul').find('a');
			$(tabs).removeClass('selected');
			$(this).addClass('selected');

			tabs.each(function () {
				$($(this).attr('href')).hide();
			});

			$($(this).attr('href')).show();
			
			return false;
		});
	},
});