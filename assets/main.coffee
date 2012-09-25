$ ->
  
  $modal = $('#modal')
  $modalImg = $('#modal .image img')
  
  # Highlight current route
  $("a[href='#{window.location.pathname}']").addClass 'highlighted'
  
  # Password protect RR campaign
  $("a[href='/rr']").click ->
    window.location = '/rr?password=' + prompt "Please enter the password"
    false
    
  # Clicking on an image blows it up
  window.blowUpImg = ($img) ->
    window.$_img = $img
    $modalImg.attr 'src', $img.attr('src')
    $('#modal').fadeIn 150
    $('body').css overflow: 'hidden'
    $('body, html').scrollTop 0
  
  $('#images img').click -> blowUpImg $(@)
  $modal.click (e) ->
    return unless $(e.target).attr('id') is 'modal' or $(e.target).hasClass('close') or
           $(e.target).hasClass 'image_container'
    $modal.fadeOut 150
    $('body').css overflow: 'visible'
    
  # Clicking on the card blows it up
  $('a.contact').click -> 
    blowUpImg $("<img src='/images/card.png'>")
    $('nav a').removeClass 'highlighted'
    $(@).addClass 'highlighted'
    
  # Arrow through imags
  $(window).keydown (e) ->
    return unless $_img?
    left = e.keyCode is 37
    right = e.keyCode is 39
    return unless left? or right?
    if left
      $nextImg = $_img.prev()
    if right
      $nextImg = $_img.next() || $('#images img:last')
    blowUpImg $nextImg