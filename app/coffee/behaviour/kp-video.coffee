(->
    $.fn.kpVideo = (options)->
      defaults = {
        autoplay: false
        preload: "none"
        loop: false
      }
      _opts = $.extend({},defaults, options)
      $(@).each ()->
        o = $.extend({}, _opts, $(@).data())
        $el = $(@)
        el = @
        $(@).removeAttr('controls') 
        $(@).attr('autoplay','autoplay') if o.autoplay is true
        $(@).attr('loop','loop') if o.loop is true
        $(@).attr('preload', o.preload)
        
        $(@).addClass('video-section') 
        $(@).wrap('<div class="video-play-section">')

        aIcons = '<a href="#" data-btn="backward"><i class="fa fa-backward"></i></a>'
        aIcons += '<a href="#" data-btn="play"><i class="fa fa-play"></i></a>'
        aIcons += '<a href="#" data-btn="pause"><i class="fa fa-pause"></i></a>'
        aIcons += '<a href="#"  data-btn="stop"><i class="fa fa-stop"></i></a>'
        aIcons += '<a href="#"  data-btn="forward"><i class="fa fa-forward"></i></a>'
        divPlayCommands = '<div class="video-play-commands">'+aIcons
        $(@).after(divPlayCommands)
        
        divSlides = '<div class="price-slide-pre-load-val"></div><div class="price-slide-val"></div><div class="val-icon"></div>'
        divPlayStatus = '<div class="video-play-status"><div class="price-slide-section"><div class="price-slide">'+divSlides
        $(@).after(divPlayStatus)        
        $(@).css({width: "100%", height: "auto"})

        rewindBtn = $(@.parentElement).find('[data-btn=backward]')
        playBtn = $(@.parentElement).find('[data-btn=play]')
        pauseBtn = $(@.parentElement).find('[data-btn=pause]')
        stopBtn = $(@.parentElement).find('[data-btn=stop]')
        forwardBtn = $(@.parentElement).find('[data-btn=forward]')
       
        videoCurrenTime = ""
        videoDuration = ""
        intervalRewind = ""
        intervalForward = ""
        videoWidth = $el.width()
        iconWidth = $($el.parent()).find('div.val-icon').width()
        videoWidth -= iconWidth - 5
        $iconVal = $($el.parent()).find('div.val-icon')
        $redLine = $($el.parent()).find('div.price-slide-val')
        $grayLine = $($el.parent()).find('div.price-slide-pre-load-val')

        $iconVal.draggable({ 
          containment: "parent" 
          drag: (e)-> 
            placeValue = parseFloat($(this).css('left'))
            percentage = placeValue / videoWidth * 100
            $($iconVal).css('left', percentage-1+'%')
            $($redLine).css('width', percentage+'%')
            videoCurrenTime = el.duration * (percentage / 100)
            el.currentTime = videoCurrenTime
        })

        $(@.parentElement).find('.price-slide').on('click', (e)->
          placeValue = e.pageX - $(@).offset().left
          percentage = placeValue / videoWidth * 100
          $($iconVal).css('left', percentage-1+'%')
          $($redLine).css('width', percentage+'%')
          videoCurrenTime = el.duration * (percentage / 100)
          el.currentTime = videoCurrenTime
        )

        $(window).on('resize', ()->
          videoWidth = $el.width()
          iconWidth = $el.width()
        )

        $(@.parentElement).find('a[data-btn]').on('click', (e)->
          e.preventDefault()
          $($el.parent()).find('a[data-btn]').find('i').removeClass('active')
          $(@).find('i').addClass('active')
        )
        

        # on click play button
        $(playBtn).on('click', (e)->
          e.preventDefault()
          el.currentTime = videoCurrenTime
          el.playbackRate = 1.0
          clearInterval(intervalRewind)
          clearInterval(intervalForward)
          $($el).trigger('play')

        )

        # on click pause button
        $(pauseBtn).on('click', (e)->
          e.preventDefault()
          el.playbackRate = 1.0
          clearInterval(intervalRewind)
          clearInterval(intervalForward)
          $($el).trigger('pause')
        )   

        # on click stop button
        $(stopBtn).on('click', (e)->
          e.preventDefault()
          el.playbackRate = 1.0
          clearInterval(intervalRewind)
          clearInterval(intervalForward)
          $($el).currentTime = 0
          videoCurrenTime = 0
          $($redLine).css('width', '0%')
          $($iconVal).css('left', '0%')
          $($el).trigger('load')
        )     
        
        # on click rewind button
        $(rewindBtn).on('click', (e)->
          e.preventDefault()
          clearInterval(intervalForward)

          $($el).trigger('pause')
          intervalRewind = setInterval( ()->
            el.playbackRate = 1.0
            videoCurrenTime = el.currentTime
            percentage =  el.currentTime / el.duration * 100
            $($redLine).css('width', percentage+'%')
            $($iconVal).css('left', percentage-1+'%')

            if el.currentTime is 0
              clearInterval(intervalRewind)
              el.pause()
            else
              el.currentTime += -.1
          ,30)
        )   

        # on click rewind button
        $(forwardBtn).on('click', (e)->
          e.preventDefault()
          clearInterval(intervalRewind)
          intervalForward= setInterval( ()->
            el.playbackRate = 3.0
            videoCurrenTime = el.currentTime
            if el.currentTime is 0
              clearInterval(intervalForward)
              el.pause()
          ,30)
        )   

        $(@).on('progress', ()->
          percentage = el.buffered.end(0) / el.duration * 100
          $($grayLine).css('width', percentage+'%')
        )

        $(@).on('loadeddata', (e)-> 
          $($el).currentTime = videoCurrenTime
        ,false)

        $(@).on('timeupdate', (e)->
          percentage =  @.currentTime / @.duration * 100
          $($redLine).css('width', percentage+'%')
          $($iconVal).css('left', percentage-1+'%')
        )

        $(@).on('ended', (e)->
          videoCurrenTime = 0
        )
      
      return
)(jQuery)