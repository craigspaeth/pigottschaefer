$ ->
  
  $modal = $('#modal')
  
  # Highlight current route
  $("a[href='#{window.location.pathname}']").addClass 'highlighted'
  
  # Password protect RR campaign
  $("a[href='/rr']").click ->
    window.location = '/rr?password=' + prompt "Please enter the password"
    false
    
  # Clicking on an image blows it up
  blowUpImg = ($img) ->
    $('#modal .image img').attr 'src', $img.attr('src')
    $('#modal').fadeIn 150
    $('body').css overflow: 'hidden'
    $('body, html').scrollTop 0
  
  $('#images img').click -> blowUpImg $(@)
  $modal.click (e) ->
    return unless $(e.target).attr('id') is 'modal' or $(e.target).hasClass('close') or
           $(e.target).hasClass 'image_container'
    $modal.fadeOut 150
    $('body').css overflow: 'visible'
    
  # Arrow through the images like a slideshow