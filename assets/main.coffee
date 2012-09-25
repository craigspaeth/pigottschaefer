$ ->
  $("a[href='/rr']").click ->
    window.location = '/rr?password=' + prompt "Please enter the password"
    false