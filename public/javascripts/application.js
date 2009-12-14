$(document).ready(function () {
	$('#guild_background_color').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
	
	$('.tabs a').act_as_tabs();
	
	$('#guild_theme').change(function(){ 
		$('body').attr('class', $(this).val());
	});
	
	$('a[rel*=facebox]').facebox();
	
	setTimeout(function () {
		$('.flash_notice, .flash_error').slideUp()
	}, 10000);
	
	$('#topic_body, #post_body').markItUp(mySettings, { previewAutoRefresh:false });
	
	$('textarea').autogrow({
		lineHeight: 18
	});
	
	$('#forum_link').click(function () {
		this.focus();
		this.select();
	});
	
	$('#new_photo') .attr('target', 'upload_frame')
									.append("<input type=\"hidden\" name=\"format\" value=\"js\"/>")
									.submit(function (){
										$(this).find('*').hide();
										$(this).append("<img src=\"/images/file_upload.gif\"></img>");
									});
	
});