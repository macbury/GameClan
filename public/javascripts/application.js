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
	
	$('a[rel*=facebox]').facebox() 
	
	setTimeout(function () {
		$('.flash_notice, .flash_error').slideUp()
	}, 10000)
	
	$('textarea').autogrow({
		lineHeight: 16
	});
});