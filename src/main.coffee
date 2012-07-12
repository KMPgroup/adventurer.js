jQuery.easing.def = "easeInOutQuint"
class Adventurer
  # "north", "east", "south", "west", 
  frames: ["content"]
  
  constructor: (options) ->
    @steps = []
    @with_navigation = options.with_navigation ? true
    @with_autoplay = options.with_autoplay ? true
    @render()
    @current_step_index = 0
    @frame_size = 10
    @default_delay = 2000
    $(window).resize () =>
      @position_frames()
      
    $(window).keyup (event) =>
      if event.keyCode == 32 or event.keyCode == 39
        @next_step() if @current_step_index < @steps.length - 1
      else if event.keyCode == 37
        @previous_step() if @current_step_index > 0
      
    
  add_step: (element, text) ->
    @steps.push
      "element": element
      "text": text
      
  begin: ->
    @show()
    @display_step()
    
    if @with_autoplay
      @pid = setInterval () =>
        if @current_step_index < @steps.length - 1
          @next_step() 
        else
          clearInterval(@pid)
          @pid = null
      , @default_delay
    
  next_step: ->
    @current_step_index++
    @display_step()
    
  previous_step: ->
    @current_step_index--
    @display_step()
    
  render: ->
    for frame in @frames
      current = $("<div class='adventurer_frame #{frame}'></div>").css "opacity": 0.5
      $("body").append current
    $(".adventurer_frame.north, .adventurer_frame.south").css "width": document.width
    this
    
  display_step: ->
    @position_frames()
    
  hide: ->
    $("body").removeClass "with_adventurer"
    $(".adventurer_frame").css "display": "none"
    
  show: ->
    $("body").addClass "with_adventurer"
    $(".adventurer_frame").css "display": "block"
    
  position_frames: ->
    window_width = $(window).width()
    window_height = $(window).height()
    
    top = @current_step().offset().top
    left = @current_step().offset().left
    width = @current_step().width()
    height = @current_step().height()
    
    b_top = top
    b_bottom = (window_height - ( top + height))
    b_right = (window_width - ( left + width ))
    b_left = left
    # if left > (window_width - ( left + width ))
    #   border_width = left
    # else  
    #   border_width = window_width - ( left + width )
    # 
    # if top > (window_height - ( top + height) )
    #   border_height = top
    # else
    #   border_height = (window_height - ( top + height ))
             
    # $(".adventurer_frame.north").stop().animate 
    #   "height": top - (@frame_size / 2), 
    #   "width": document.width
    # $(".adventurer_frame.south").stop().animate 
    #   "height": document.height - height - top - (@frame_size / 2), 
    #   "width": document.width
    # $(".adventurer_frame.west").stop().animate 
    #   "top": top - (@frame_size / 2), 
    #   "width": left - (@frame_size / 2), 
    #   "height": height + @frame_size
    # $(".adventurer_frame.east").stop().animate 
    #   "top": top - (@frame_size / 2),
    #   "left": left + width + (@frame_size / 2),
    #   "width": document.width - left - width - (@frame_size / 2), 
    #   "height": height + @frame_size
    $(".adventurer_frame.content").stop().animate
      "border-top-width": b_top,
      "border-bottom-width": b_bottom,
      "border-left-width": b_left,
      "border-right-width": b_right, 
      "top": top - (@frame_size / 2) - b_top, 
      "left": left - (@frame_size / 2) - b_left, 
      "width": width + @frame_size - 1, 
      "height": height + @frame_size - 1
  
  animate_step: (time, steps) ->
    one_step = time/steps
    
    
    
  current_step: ->
    $(@steps[@current_step_index].element)
    
  initialize_view: ->
    
    
  render_navigation: ->
    
window.Adventurer = Adventurer
    