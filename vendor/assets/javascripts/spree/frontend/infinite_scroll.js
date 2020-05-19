var BWLD = {}
var page = 2;
jQuery(function() {
        $(window).on('scroll', function() {
            if ($('.pagination').length > 0) {
                var more_posts_url = $('.pagination a[rel=next]').attr('href');
                var bottom_distance = $('#footer').height()-20;
                if (more_posts_url) {
                    var lengt_url = $('.pagination a[rel=next]').attr('href').length;
                    var posInit = more_posts_url.indexOf("page=")+5;
                    var nro_page = more_posts_url.substring(posInit,lengt_url);
                }
                if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - bottom_distance && nro_page==page) {
                    page++;
                    $.getScript(more_posts_url);
                }
            }
        });
});