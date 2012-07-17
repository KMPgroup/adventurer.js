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
    @menu_position = 0 #0 - hidden 1 - visible
    
    $(window).resize () =>
      @position_frames()
      
    $(window).keyup (event) =>
      $(".hover").hide()
      if event.keyCode == 32 or event.keyCode == 39
        @next_step() if @current_step_index < @steps.length - 1
      else if event.keyCode == 37
        @previous_step() if @current_step_index > 0
      
    
    
  add_step: (element, text) ->
    @steps.push
      "element": element
      "text": text
      
  # add_hovers: () ->
  #   for step in @steps    
  #     $(step.element).after("<div class ='hover' style ='display:none'>#{step.text}</div>")
  
  initialize_navigation: () ->
    that = this
    $(".navigation_toggler").click( () ->
      if that.menu_position == 1
        
        an = "-30px"
        nt = "0px"
        that.menu_position = 0
      else
        an = "0px"
        nt = "30px"
        that.menu_position = 1
      $(".adventurer_navigation").animate({
        bottom: an
      })
      
      $(".navigation_toggler").animate({
        bottom: nt
      })  
    )
    
    $(".adventurer_navigation .a_next_step").live("click", () ->
      $(".hover").hide()
      that.next_step() if that.current_step_index < that.steps.length - 1
    )
    
    $(".adventurer_navigation .a_prev_step").live("click", () ->
      $(".hover").hide()
      that.previous_step() if that.current_step_index > 0
    )
        
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
      current = $("<div class='adventurer_frame #{frame}'></div>")# .css "opacity": 0.5
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
    $(".adventurer_frame").append("<div class ='hover' style =''></div>")
  
    
  position_frames: ->
    that = this  
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

    

    $(".adventurer_frame.content").stop().animate {
      "border-top-width": b_top,
      "border-bottom-width": b_bottom,
      "border-left-width": b_left,
      "border-right-width": b_right, 
      "top": top - (@frame_size / 2) - b_top, 
      "left": left - (@frame_size / 2) - b_left, 
      "width": width + @frame_size - 1, 
      "height": height + @frame_size - 1
    }, 
    500, 
    () ->
      text = that.steps[that.current_step_index].text
      $(".adventurer_frame .hover").html("#{text}").css("bottom", "#{-height - 15}px").fadeIn()
      $(".adventurer_frame.content").css("overflow", "visible")    
      $(".current_step_count").html("Krok #{that.current_step_index + 1} z #{that.steps.length}")
      
  animate_step: (time, steps) ->
    one_step = time/steps
    
    
    
  current_step: ->
    $(@steps[@current_step_index].element)
    
  initialize_view: ->
    
    
  render_navigation: ->
    
window.Adventurer = Adventurer
    