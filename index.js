
(function ($) {
    $(document).ready(function () {
        $(".icons .fa-arrow-circle-left").click(function (ev) {
            ev.preventDefault()
            swiper.swipePrev()
        })
        $(".icons .fa-arrow-circle-right").click(function (ev) {
            ev.preventDefault()
            swiper.swipeNext()
        })
    })
})(jQuery)

