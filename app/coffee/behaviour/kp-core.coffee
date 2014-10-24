(->
	$.fn.kpSlider = ( options ) ->
		defaults =
			'unit' : '%',
			'min': 0,
			'max' : 100,
			'value' : 70
		

		_opts = $.extend({}, defaults, options)

		$(@).each () ->
			o = $.extend({}, _opts, $(@).data())
			$el = $(@)
			el = @

			$iconVal = $(@).find('div.val-icon')
			$slideVal = $(@).find('div.price-slide-val')
			$txtVal = $(@).find('div.val')
			nSlideWidth = parseInt $(@).outerWidth()
			nValIconWidth = parseInt $($iconVal).outerWidth()
			placeValue = parseInt (nSlideWidth - nValIconWidth) / (o.max - o.min) * (o.value - o.min)
			$($slideVal).css("width", placeValue + "px")
			$($iconVal).css("left", placeValue + "px")
			$($txtVal).text(o.value + o.unit)
			txtWidth = parseInt($($txtVal).outerWidth())
			txtWidth = ( txtWidth - nValIconWidth ) / 2
			$($txtVal).css( "left", (placeValue - txtWidth) + "px" )

			$iconVal.draggable({ 
				containment: "parent" 
				drag: (e)->
					placeValue = parseInt $(this).css('left')
					$($slideVal).css("width", placeValue + "px")
					val = parseInt (o.max - o.min) / (nSlideWidth - nValIconWidth) * placeValue + o.min
					$($txtVal).text(val + o.unit)
					txtWidth = parseInt($($txtVal).outerWidth())
					txtWidth = ( txtWidth - nValIconWidth ) / 2
					$($txtVal).css( "left", (placeValue - txtWidth) + "px" )
			})

	# class rangeSliderControl
	# 	constructor : ( options ) ->
	# 		this.sliderId = options['render-to']
	# 		this.value1 = parseInt options['value1']
	# 		this.value2 = parseInt options['value2']
	# 		this.min = parseInt options['min']
	# 		this.max = parseInt options['max']
	# 		this.sliderObj = document.getElementById this.sliderId

	# 		if this.sliderObj?
	# 			return 

	# 		$( "#" + this.sliderId + " .val1" ).attr( "data-value", this.value1 )
	# 		$( "#" + this.sliderId + " .val2" ).attr( "data-value", this.value2 )
	# 		$( "#" + this.sliderId + " .price-slide-val" ).attr( "data-min", this.min )
	# 		$( "#" + this.sliderId + " .price-slide-val" ).attr( "data-max", this.max )

	# 		this.init()
		
	# 	refreshTimeoutIdx: 0

	# 	init : () ->
	# 		valMin = parseInt $( "#" + this.sliderId + " .price-slide-val" ).attr( "data-min" )
	# 		valMax = parseInt $( "#" + this.sliderId + " .price-slide-val" ).attr( "data-max" )
	# 		valRange = valMax - valMin
	# 		value1 = parseInt $( "#" + this.sliderId + " .val1" ).attr( "data-value" )
	# 		value2 = parseInt $( "#" + this.sliderId + " .val2" ).attr( "data-value" )

	# 		n_sliderSectionWidth = parseInt $( "#" + this.sliderId ).outerWidth()
			
	# 		n_val1SliderWidth = parseInt $( "#" + this.sliderId + " .val1-icon" ).outerWidth()
	# 		n_val1SliderPos = parseInt ( value1 - valMin ) * n_sliderSectionWidth / valRange
	# 		n_val1SliderLeft =  parseInt ( value1 - valMin ) * n_sliderSectionWidth / valRange  - n_val1SliderWidth / 2

	# 		$( "#" + this.sliderId + " .val1-icon" ).css( "left", n_val1SliderLeft + "px" )
	# 		$( "#" + this.sliderId + " .price-slide-val" ).css( "left", parseInt( value1 * n_sliderSectionWidth / 100.0 ) + "px" )

	# 		$( "#" + this.sliderId + " .val1" ).text( "$" + value1 )
	# 		n_textWidth = parseInt $( "#" + this.sliderId + " .val1" ).outerWidth()
	# 		n_textLeft =  parseInt ( value1 - valMin ) * n_sliderSectionWidth / valRange  - n_textWidth / 2
	# 		$( "#" + this.sliderId + " .val1" ).css( "left", n_textLeft + "px" )

	# 		n_val2SliderWidth = parseInt $( "#" + this.sliderId + " .val2-icon" ).outerWidth()
	# 		n_val2SliderPos = parseInt ( value2 - valMin ) * n_sliderSectionWidth / valRange
	# 		n_val2SliderLeft =  parseInt ( value2 - valMin ) * n_sliderSectionWidth / valRange  - n_val1SliderWidth / 2

	# 		$( "#" + this.sliderId + " .val2-icon" ).css( "left", n_val2SliderLeft + "px" )
	# 		$( "#" + this.sliderId + " .price-slide-val" ).css( "left", parseInt( value1 * n_sliderSectionWidth / 100.0 ) + "px" )

	# 		$( "#" + this.sliderId + " .val2" ).text( "$" + value2 )
	# 		n_textWidth = parseInt $( "#" + this.sliderId + " .val1" ).outerWidth()
	# 		n_textLeft =  parseInt ( value2 - valMin ) * n_sliderSectionWidth / valRange  - n_textWidth / 2
	# 		$( "#" + this.sliderId + " .val2" ).css( "left", n_textLeft + "px" )

	# 		$( "#" + this.sliderId + " .price-slide-val" ).css( "left", n_val1SliderLeft + "px" ).css( "width", ( n_val2SliderPos - n_val1SliderPos ) + "px" )

	# 		sliderControlObj = this

	# 		$( "#" + this.sliderId + " .val-icon" ).each(->
	# 			this.addEventListener( 
	# 				"mousedown", 
	# 				( e_event ) ->
	# 					sliderControlObj.sliderMouseDown this, sliderControlObj.sliderId, e_event
	# 				,
	# 				false 
	# 			)

	# 			this.addEventListener(
	# 				"touchstart", 
	# 				( e_event ) -> 
	# 					sliderControlObj.sliderMouseDown this, sliderControlObj.sliderId, e_event
	# 				,  
	# 				false
	# 			)
	# 		)

	# 		if document.addEventListener
	# 			$(document).bind('touchmove', ( e_event ) ->
	# 				sliderControlObj.sliderMouseMove e_event
	# 			)

	# 			$(document).bind('touchend', ( e_event ) ->
	# 				sliderControlObj.sliderMouseUp e_event
	# 			)

	# 		$( document ).mousemove( ( e_event )->
	# 			sliderControlObj.sliderMouseMove e_event
	# 		)

	# 		$( document ).mouseup( ( e_event ) ->
	# 			sliderControlObj.sliderMouseUp e_event
	# 		)

	# 		redrawFunc = this

	# 		$( window ).resize(->
	# 			clearTimeout( refreshTimeoutIdx )
	# 			refreshTimeoutIdx = setTimeout ()->
	# 				redrawFunc.init()
	# 			,500
	# 		)

	# 	sliderMouseDown : ( obj, sliderId, e_event ) ->
	# 		window.n_activeRangeSliderId = sliderId
	# 		$( obj ).addClass("selected-val-icon")

	# 	sliderMouseMove : ( e_event ) ->
	# 		if not e_event and window.event
	# 			e_event = window.event

	# 		if window.n_activeRangeSliderId?
	# 			mousePositionX = e_event.clientX

	# 			if e_event and e_event.originalEvent.touches
	# 				e_event.preventDefault()
	# 				e_touch = e_event.originalEvent.touches[0] || e_event.originalEvent.changedTouches[0]
	# 				mousePositionX = e_touch.pageX

	# 			n_sliderSectionWidth = parseInt $( "#" + window.n_activeRangeSliderId ).outerWidth()
	# 			n_sliderWidth = parseInt $( "#" + window.n_activeRangeSliderId + " .selected-val-icon").outerWidth()
	# 			n_sliderOffsetLeft = $( "#" + window.n_activeRangeSliderId ).offset()

	# 			n_currentSliderLeft = parseInt $( "#" + window.n_activeRangeSliderId + " .selected-val-icon" ).css("left")
	# 			n_sliderLeft = parseInt mousePositionX - n_sliderOffsetLeft.left

	# 			if n_sliderLeft < 0
	# 				n_sliderLeft = 0 
	# 			else if n_sliderLeft > n_sliderSectionWidth
	# 				n_sliderLeft = n_sliderSectionWidth

	# 			$( "#" + window.n_activeRangeSliderId + " .price-slide-val" ).css( "width", parseInt n_sliderLeft + "px" )
	# 			$( "#" + window.n_activeRangeSliderId + " .selected-val-icon" ).css( "left", parseInt( n_sliderLeft - n_sliderWidth / 2 ) + "px" )

	# 			minVal = parseInt $( "#" + window.n_activeRangeSliderId + " .price-slide-val" ).data( "min" )
	# 			maxVal = parseInt $( "#" + window.n_activeRangeSliderId + " .price-slide-val" ).data( "max" )
	# 			n_sliderValue = parseInt( n_sliderLeft * ( maxVal - minVal ) / n_sliderSectionWidth ) + parseInt minVal

	# 			selectedValClass = $( "#" + window.n_activeRangeSliderId + " .selected-val-icon" ).data( "valclass" )
	# 			$( "#" + window.n_activeRangeSliderId + " ." + selectedValClass ).text( "$" + n_sliderValue )

	# 			n_textWidth = parseInt $( "#" + window.n_activeRangeSliderId + " ." + selectedValClass ).outerWidth()
	# 			n_textLeft =  parseInt n_sliderValue * n_sliderSectionWidth / ( maxVal - minVal )  - n_textWidth / 2
	# 			$( "#" + window.n_activeRangeSliderId + " ." + selectedValClass ).css( "left", n_textLeft + "px" )

	# 			$( "#" + window.n_activeRangeSliderId + " ." + selectedValClass ).attr( "data-value", n_sliderValue )

	# 			valMin = parseInt $( "#" + window.n_activeRangeSliderId + " .price-slide-val" ).attr( "data-min" )
	# 			valMax = parseInt $( "#" + window.n_activeRangeSliderId + " .price-slide-val" ).attr( "data-max" )
	# 			valRange = valMax - valMin
	# 			value1 = parseInt $( "#" + window.n_activeRangeSliderId + " .val1" ).attr( "data-value" )
	# 			value2 = parseInt $( "#" + window.n_activeRangeSliderId + " .val2" ).attr( "data-value" )

	# 			if value1 > value2
	# 				tmpVal = value2
	# 				value2 = value1
	# 				value1 = tmpVal

	# 			n_val1SliderWidth = parseInt $( "#" + window.n_activeRangeSliderId + " .val1-icon" ).outerWidth()
	# 			n_val1SliderLeft =  parseInt ( value1 - valMin ) * n_sliderSectionWidth / valRange  - 	n_val1SliderWidth / 2
	# 			n_val1SliderPos = parseInt ( value1 - valMin ) * n_sliderSectionWidth / valRange
	# 			n_val2SliderPos = parseInt ( value2 - valMin ) * n_sliderSectionWidth / valRange

	# 			$( "#" + window.n_activeRangeSliderId + " .price-slide-val" ).css( "left", n_val1SliderLeft + "px" ).css( "width", ( n_val2SliderPos - n_val1SliderPos ) + "px" )

	# 	sliderMouseUp : ( e_event ) ->	
	# 			if window.n_activeRangeSliderId?
	# 				$( "#" + window.n_activeRangeSliderId + " .val-icon" ).removeClass( "selected-val-icon" )
	# 				window.n_activeRangeSliderId = null;

	# class volumnSliderControl
	# 	constructor : ( options ) ->
	# 		this.sliderId = options['render-to']
	# 		this.initValue = parseInt options['value']
	# 		this.sliderObj = document.getElementById this.sliderId

	# 		if this.sliderObj?
	# 			return 

	# 		this.sliderValObj = $('.val-icon', this.sliderObj)[0]

	# 		$( "#" + this.sliderId + " .volume-slide-val" ).attr( "data-value", this.initValue )

	# 		this.init()
		
	# 	refreshTimeoutIdx: 0

	# 	init : () ->
	# 		n_initValue = parseInt $( "#" + this.sliderId + " .volume-slide-val" ).attr( "data-value" )

	# 		n_sliderSectionWidth = parseInt $( "#" + this.sliderId ).outerWidth()
	# 		n_sliderWidth = parseInt $( this.sliderValObj ).outerWidth()
	# 		n_sliderLeft =  parseInt n_initValue * n_sliderSectionWidth / 100.0  - n_sliderWidth / 2

	# 		$( this.sliderValObj ).css( "left", n_sliderLeft + "px" )
	# 		$( "#" + this.sliderId + " .volume-slide-val" ).css( "width", parseInt( n_initValue * n_sliderSectionWidth / 100.0 ) + "px" )

	# 		sliderControlObj = this

	# 		this.sliderValObj.addEventListener( 
	# 			"mousedown", 
	# 			( e_event ) ->
	# 				sliderControlObj.sliderMouseDown sliderControlObj.sliderId, e_event
	# 			,
	# 			false 
	# 		)

	# 		if document.addEventListener
	# 			this.sliderValObj.addEventListener(
	# 				"touchstart", 
	# 				( e_event ) -> 
	# 					sliderControlObj.sliderMouseDown sliderControlObj.sliderId, e_event
	# 				,  
	# 				false
	# 			)
				
	# 			$(document).bind('touchmove', ( e_event ) ->
	# 				sliderControlObj.sliderMouseMove e_event
	# 			)

	# 			$(document).bind('touchend', ( e_event ) ->
	# 				sliderControlObj.sliderMouseUp e_event
	# 			)

	# 		$( document ).mousemove( ( e_event ) ->
	# 			sliderControlObj.sliderMouseMove e_event
	# 		)

	# 		$( document ).mouseup( ( e_event ) ->
	# 			sliderControlObj.sliderMouseUp e_event
	# 		)

	# 		redrawFunc = this

	# 		$( window ).resize(->
	# 			clearTimeout( refreshTimeoutIdx )
	# 			refreshTimeoutIdx = setTimeout ()->
	# 				redrawFunc.init()
	# 			,500
	# 		)

	# 	sliderMouseDown : ( sliderId, e_event ) ->
	# 		window.n_activeVolumnSliderId = sliderId

	# 	sliderMouseMove : ( e_event ) ->
	# 		if not e_event and window.event
	# 			e_event = window.event

	# 		if window.n_activeVolumnSliderId?
	# 			mousePositionX = e_event.clientX

	# 			if e_event and e_event.originalEvent.touches
	# 				e_event.preventDefault()
	# 				e_touch = e_event.originalEvent.touches[0] || e_event.originalEvent.changedTouches[0]
	# 				mousePositionX = e_touch.pageX

	# 			n_sliderSectionWidth = parseInt $( "#" + window.n_activeVolumnSliderId ).outerWidth()
	# 			n_sliderWidth = parseInt $( "#" + window.n_activeVolumnSliderId + " .val-icon").outerWidth()
	# 			n_sliderOffsetLeft = $( "#" + window.n_activeVolumnSliderId ).offset()

	# 			n_currentSliderLeft = parseInt $( "#" + window.n_activeVolumnSliderId + " .val-icon" ).css("left")
	# 			n_sliderLeft = parseInt mousePositionX - n_sliderOffsetLeft.left

	# 			if n_sliderLeft < 0
	# 				n_sliderLeft = 0 
	# 			else if n_sliderLeft > n_sliderSectionWidth
	# 				n_sliderLeft = n_sliderSectionWidth

	# 			$( "#" + window.n_activeVolumnSliderId + " .volume-slide-val" ).css( "width", parseInt n_sliderLeft + "px" )
	# 			$( "#" + window.n_activeVolumnSliderId + " .val-icon" ).css( "left", parseInt( n_sliderLeft - n_sliderWidth / 2 ) + "px" )

	# 			n_sliderValue = parseInt( n_sliderLeft * 100.0 / n_sliderSectionWidth )

	# 			$( "#" + window.n_activeVolumnSliderId + " .val" ).text( n_sliderValue + "%" )
	# 			$( "#" + window.n_activeVolumnSliderId + " .volume-slide-val" ).attr( "data-value", n_sliderValue )

	# 	sliderMouseUp : ( e_event ) ->		
	# 			if window.n_activeVolumnSliderId?
	# 				window.n_activeVolumnSliderId = null;
					
	# new sliderControl
	# 	'render-to' : 'slider3'
	# 	'value'		: 50

	# new rangeSliderControl
	# 	'render-to' : 'slider1'
	# 	'min'		: 0
	# 	'max'		: 400
	# 	'value1'	: 50
	# 	'value2'	: 250

	# new rangeSliderControl
	# 	'render-to' : 'slider2'
	# 	'min'		: 0
	# 	'max'		: 400
	# 	'value1'	: 50
	# 	'value2'	: 250

	# new volumnSliderControl
	# 	'render-to' : 'volumn-slider'
	# 	'value'		: 50

	# $(".nano").nanoScroller({ scroll: 'top' })
	# $('#slider').nivoSlider()
	# $('#side-slider').nivoSlider()
)(jQuery)