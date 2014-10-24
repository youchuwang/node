$(->
	class drawPieChart
		constructor : ( options ) ->
			this.options = options
			this.init()

		refreshTimeoutIdx: 0
		init : () ->
			$('#' + this.options['render-to']).html('<canvas></canvas>')

			wrapWidth = $('#' + this.options['render-to']).width()

			this.options['width'] = wrapWidth if wrapWidth < this.options['width']

			this.canvas = $('#' + this.options['render-to'] + ' canvas')[0]	
			this.context = this.canvas.getContext '2d'

			this.canvas.style.background = this.options['background-color']
			this.canvas.width = this.options['width']
			this.canvas.height = this.options['height']

			this.centerX = this.canvas.width / 2
			this.centerY = this.canvas.height / 2
			this.r = 40

			this.context.lineWidth = this.options['line-width']
			this.context.font = this.options['font-size'] + ' ' +  this.options['font-family']

			this.drawPie( data ) for data in this.options['datas']

			redrawFunc = this

			$(window).resize(->
				clearTimeout(refreshTimeoutIdx)
				refreshTimeoutIdx = setTimeout ()->
					redrawFunc.init()
				,500
			)

		drawPie : ( data ) ->
			startAngle = 1.5 * Math.PI
			endAngle = ( 1.5 - data['value'] / 100 * 2 ) * Math.PI

			this.context.beginPath()
			this.context.arc( this.centerX, this.centerY, this.r, startAngle, endAngle, true )
			this.context.strokeStyle = data['line-color']
			this.context.stroke()

			this.context.fillStyle = pie_graph_data['font-color']
			this.context.fillText( data['value'] + '%', this.centerX + 10, this.centerY - this.r + 5 )
			this.r = this.r + 20

	pie_graph_data =
	    'render-to' : 'statistics-pie-chart'
	    'width' : 340
	    'height' : 260
	    'background-color' : '#1f1f1f'
	    'line-width' : 15
	    'font-family' : 'Open Sans'
	    'font-size' : '12px'
	    'font-color' : '#ffffff',
	    'responsive' : true
	    'datas' : [
	        { 'value' : 55, 'line-color' : '#636f80' }
	        { 'value' : 60, 'line-color' : '#fa6f57' }
	        { 'value' : 50, 'line-color' : '#009be0' }
	        { 'value' : 30, 'line-color' : '#1ab1aa' }
	    ]

	new drawPieChart pie_graph_data 
);