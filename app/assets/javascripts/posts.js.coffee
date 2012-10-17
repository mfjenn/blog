# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  donation.setupForm()

donation =
  setupForm: ->
    $('#new_donation').submit ->
      $('input[type=submit]').attr('disabled', true)
      donation.processCard()
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, donation.handleStripeResponse)
  
handleStripeResponse: (status, response) ->
		  if status == 200
		    alert(response.id)
		  else
		    $('#stripe_error').text(response.error.message)
		    $('input[type=submit]').attr('disabled', false)

