(function() {
  return $.fn.kpVideo = function(options) {
    var defaults, _opts;
    defaults = {
      autoplay: false,
      preload: "none",
      loop: false
    };
    _opts = $.extend({}, defaults, options);
    $(this).each(function() {
      var $el, $grayLine, $iconVal, $redLine, aIcons, divPlayCommands, divPlayStatus, divSlides, el, forwardBtn, iconWidth, intervalForward, intervalRewind, o, pauseBtn, playBtn, rewindBtn, stopBtn, videoCurrenTime, videoDuration, videoWidth;
      o = $.extend({}, _opts, $(this).data());
      $el = $(this);
      el = this;
      $(this).removeAttr('controls');
      if (o.autoplay === true) {
        $(this).attr('autoplay', 'autoplay');
      }
      if (o.loop === true) {
        $(this).attr('loop', 'loop');
      }
      $(this).attr('preload', o.preload);
      $(this).addClass('video-section');
      $(this).wrap('<div class="video-play-section">');
      aIcons = '<a href="#" data-btn="backward"><i class="fa fa-backward"></i></a>';
      aIcons += '<a href="#" data-btn="play"><i class="fa fa-play"></i></a>';
      aIcons += '<a href="#" data-btn="pause"><i class="fa fa-pause"></i></a>';
      aIcons += '<a href="#"  data-btn="stop"><i class="fa fa-stop"></i></a>';
      aIcons += '<a href="#"  data-btn="forward"><i class="fa fa-forward"></i></a>';
      divPlayCommands = '<div class="video-play-commands">' + aIcons;
      $(this).after(divPlayCommands);
      divSlides = '<div class="price-slide-pre-load-val"></div><div class="price-slide-val"></div><div class="val-icon"></div>';
      divPlayStatus = '<div class="video-play-status"><div class="price-slide-section"><div class="price-slide">' + divSlides;
      $(this).after(divPlayStatus);
      $(this).css({
        width: "100%",
        height: "auto"
      });
      rewindBtn = $(this.parentElement).find('[data-btn=backward]');
      playBtn = $(this.parentElement).find('[data-btn=play]');
      pauseBtn = $(this.parentElement).find('[data-btn=pause]');
      stopBtn = $(this.parentElement).find('[data-btn=stop]');
      forwardBtn = $(this.parentElement).find('[data-btn=forward]');
      videoCurrenTime = "";
      videoDuration = "";
      intervalRewind = "";
      intervalForward = "";
      videoWidth = $el.width();
      iconWidth = $($el.parent()).find('div.val-icon').width();
      videoWidth -= iconWidth - 5;
      $iconVal = $($el.parent()).find('div.val-icon');
      $redLine = $($el.parent()).find('div.price-slide-val');
      $grayLine = $($el.parent()).find('div.price-slide-pre-load-val');
      $iconVal.draggable({
        containment: "parent",
        drag: function(e) {
          var percentage, placeValue;
          placeValue = parseFloat($(this).css('left'));
          percentage = placeValue / videoWidth * 100;
          $($iconVal).css('left', percentage - 1 + '%');
          $($redLine).css('width', percentage + '%');
          videoCurrenTime = el.duration * (percentage / 100);
          return el.currentTime = videoCurrenTime;
        }
      });
      $(this.parentElement).find('.price-slide').on('click', function(e) {
        var percentage, placeValue;
        placeValue = e.pageX - $(this).offset().left;
        percentage = placeValue / videoWidth * 100;
        $($iconVal).css('left', percentage - 1 + '%');
        $($redLine).css('width', percentage + '%');
        videoCurrenTime = el.duration * (percentage / 100);
        return el.currentTime = videoCurrenTime;
      });
      $(window).on('resize', function() {
        videoWidth = $el.width();
        return iconWidth = $el.width();
      });
      $(this.parentElement).find('a[data-btn]').on('click', function(e) {
        e.preventDefault();
        $($el.parent()).find('a[data-btn]').find('i').removeClass('active');
        return $(this).find('i').addClass('active');
      });
      $(playBtn).on('click', function(e) {
        e.preventDefault();
        el.currentTime = videoCurrenTime;
        el.playbackRate = 1.0;
        clearInterval(intervalRewind);
        clearInterval(intervalForward);
        return $($el).trigger('play');
      });
      $(pauseBtn).on('click', function(e) {
        e.preventDefault();
        el.playbackRate = 1.0;
        clearInterval(intervalRewind);
        clearInterval(intervalForward);
        return $($el).trigger('pause');
      });
      $(stopBtn).on('click', function(e) {
        e.preventDefault();
        el.playbackRate = 1.0;
        clearInterval(intervalRewind);
        clearInterval(intervalForward);
        $($el).currentTime = 0;
        videoCurrenTime = 0;
        $($redLine).css('width', '0%');
        $($iconVal).css('left', '0%');
        return $($el).trigger('load');
      });
      $(rewindBtn).on('click', function(e) {
        e.preventDefault();
        clearInterval(intervalForward);
        $($el).trigger('pause');
        return intervalRewind = setInterval(function() {
          var percentage;
          el.playbackRate = 1.0;
          videoCurrenTime = el.currentTime;
          percentage = el.currentTime / el.duration * 100;
          $($redLine).css('width', percentage + '%');
          $($iconVal).css('left', percentage - 1 + '%');
          if (el.currentTime === 0) {
            clearInterval(intervalRewind);
            return el.pause();
          } else {
            return el.currentTime += -.1;
          }
        }, 30);
      });
      $(forwardBtn).on('click', function(e) {
        e.preventDefault();
        clearInterval(intervalRewind);
        return intervalForward = setInterval(function() {
          el.playbackRate = 3.0;
          videoCurrenTime = el.currentTime;
          if (el.currentTime === 0) {
            clearInterval(intervalForward);
            return el.pause();
          }
        }, 30);
      });
      $(this).on('progress', function() {
        var percentage;
        percentage = el.buffered.end(0) / el.duration * 100;
        return $($grayLine).css('width', percentage + '%');
      });
      $(this).on('loadeddata', function(e) {
        return $($el).currentTime = videoCurrenTime;
      }, false);
      $(this).on('timeupdate', function(e) {
        var percentage;
        percentage = this.currentTime / this.duration * 100;
        $($redLine).css('width', percentage + '%');
        return $($iconVal).css('left', percentage - 1 + '%');
      });
      return $(this).on('ended', function(e) {
        return videoCurrenTime = 0;
      });
    });
  };
})(jQuery);
