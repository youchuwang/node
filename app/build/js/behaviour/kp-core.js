(function() {
  return $.fn.kpSlider = function(options) {
    var defaults, _opts;
    defaults = {
      'unit': '%',
      'min': 0,
      'max': 100,
      'value': 70
    };
    _opts = $.extend({}, defaults, options);
    return $(this).each(function() {
      var $el, $iconVal, $slideVal, $txtVal, el, nSlideWidth, nValIconWidth, o, placeValue, txtWidth;
      o = $.extend({}, _opts, $(this).data());
      $el = $(this);
      el = this;
      $iconVal = $(this).find('div.val-icon');
      $slideVal = $(this).find('div.price-slide-val');
      $txtVal = $(this).find('div.val');
      nSlideWidth = parseInt($(this).outerWidth());
      nValIconWidth = parseInt($($iconVal).outerWidth());
      placeValue = parseInt((nSlideWidth - nValIconWidth) / (o.max - o.min) * (o.value - o.min));
      $($slideVal).css("width", placeValue + "px");
      $($iconVal).css("left", placeValue + "px");
      $($txtVal).text(o.value + o.unit);
      txtWidth = parseInt($($txtVal).outerWidth());
      txtWidth = (txtWidth - nValIconWidth) / 2;
      $($txtVal).css("left", (placeValue - txtWidth) + "px");
      return $iconVal.draggable({
        containment: "parent",
        drag: function(e) {
          var val;
          placeValue = parseInt($(this).css('left'));
          $($slideVal).css("width", placeValue + "px");
          val = parseInt((o.max - o.min) / (nSlideWidth - nValIconWidth) * placeValue + o.min);
          $($txtVal).text(val + o.unit);
          txtWidth = parseInt($($txtVal).outerWidth());
          txtWidth = (txtWidth - nValIconWidth) / 2;
          return $($txtVal).css("left", (placeValue - txtWidth) + "px");
        }
      });
    });
  };
})(jQuery);
