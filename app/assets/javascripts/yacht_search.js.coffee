# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# create namespace
yl = {} if (typeof yl == 'undefined')
yl.search = {} if (typeof yl.search == 'undefined')

yl.search.getFilter = ()->
    hulls = []
    marinas = []
    models = []
    boat_attributes = []

    for elm in $('#search-filter-form input[name=hull\\[\\]]:checked')
        hulls.push( elm.value )

    for elm in $('#search-filter-form input[name=marina\\[\\]]:checked')
        marinas.push( elm.value )
      
    if $('#search-filter-form input[name=boat_attributes\\[\\]]:checked').length == 0
        for elm in $('#search-filter-form input[name=boat_attributes\\[\\]]')
            if elm.value.split(',')[1] == 'true' || elm.value.split(',')[1] == 'false'
              boat_attributes.push( elm.value.split(',')[0] )
            else
              boat_attributes.push( elm.value.split(',')[1] )
    else
      for elm in $('#search-filter-form input[name=boat_attributes\\[\\]]:checked')
          if elm.value.split(',')[1] == 'true' || elm.value.split(',')[1] == 'false'
            boat_attributes.push( elm.value.split(',')[0] )
          else
            boat_attributes.push( elm.value.split(',')[1] )

    for elm in $('#search-filter-form input[name=model\\[\\]]:checked')
        models.push( elm.value )

    min_cabins = parseInt($('#cabins-amount').val())
    max_age = parseInt($('#age-amount').val())
    min_length = parseInt($('#length-amount').val())

    filter = {
        'hulls': hulls
        'marinas': marinas
        'models': models
        'boat_attributes': boat_attributes
        'min_cabins': min_cabins
        'max_age': max_age
        'min_length': min_length
    }
    return filter

yl.search.getUrlParams = (object_changed)->
    hulls = []
    marinas = []
    models = []
    boat_attributes = []
    filter = {}

    if object_changed == 'hull'
        for elm in $('#search-filter-form input[name=hull\\[\\]]:checked')
            hulls.push( elm.value )
        filter = {'hulls': hulls}

    if object_changed == 'marina'
        for elm in $('#search-filter-form input[name=marina\\[\\]]:checked')
            marinas.push( elm.value )
        filter = {'marinas': marinas}

    if object_changed == 'boat_attributes'
        if $('#search-filter-form input[name=boat_attributes\\[\\]]:checked').length == 0
            for elm in $('#search-filter-form input[name=boat_attributes\\[\\]]')
                if elm.value.split(',')[1] == 'true' || elm.value.split(',')[1] == 'false'
                  boat_attributes.push( elm.value.split(',')[0] )
                else
                  boat_attributes.push( elm.value.split(',')[1] )
            filter = {'boat_attributes': boat_attributes}
        else
          for elm in $('#search-filter-form input[name=boat_attributes\\[\\]]:checked')
              if elm.value.split(',')[1] == 'true' || elm.value.split(',')[1] == 'false'
                boat_attributes.push( elm.value.split(',')[0] )
              else
                boat_attributes.push( elm.value.split(',')[1] )
          filter = {'boat_attributes': boat_attributes}

    if object_changed == 'model'
        for elm in $('#search-filter-form input[name=model\\[\\]]:checked')
            models.push( elm.value )
        filter = {'models': models}

    min_cabins = parseInt($('#cabins-amount').val())
    max_age = parseInt($('#age-amount').val())
    min_length = parseInt($('#length-amount').val())
    if object_changed == 'min_cabins'
        filter = {'min_cabins': min_cabins}

    if object_changed == 'max_age'
        filter = {'max_age': max_age}

    if object_changed == 'min_length'
        filter = {'min_length': min_length}

    return filter

###
Convert filter to query string
###
yl.search.serializeFilter = (filter)->
    jsonText = JSON.stringify(filter)
    return 'filters=' + encodeURIComponent(jsonText)

###
Get filter from query string
###
yl.search.deserializeFilter = (text)->
    tokens = text.split('=')

    if tokens[0] == '#filters'
        jsonText = decodeURIComponent(tokens[1])
        filter = JSON.parse(jsonText)
        return filter
    else
        return null

yl.search.filterBoats = (object_changed)->
    filter = yl.search.getFilter(object_changed)
    params = yl.search.getUrlParams(object_changed)
    # grab params
    hulls = filter['hulls']
    marinas = filter['marinas']
    models = filter['models']
    boat_attributes = filter['boat_attributes']
    min_cabins = filter['min_cabins']
    max_age = filter['max_age']
    min_length = filter['min_length']

    # filter yachts
    yachts = $('#default-view article')
    for yacht in yachts
        yacht = $(yacht)
        hide = false
        
        if yacht.attr('length') < min_length
            hide = true
      
        if yacht.attr('age') > max_age
            hide = true

        if yacht.attr('cabins') < min_cabins
            hide = true

        if yacht.attr('marina') not in marinas
            hide = true

        if yacht.attr('hull') not in hulls
            hide = true

        if yacht.attr('model') not in models
            hide = true
            
        boat_attr = yacht.attr('boat_attributes').split(',')
        contained = []
        for ba in boat_attr
            contained.push(boat_attributes.indexOf(ba) >= 0)
        if contained.indexOf(true) < 0
            hide = true

        if hide
            yacht.hide()
        else
            yacht.show()

    # set hashbang url
    window.location.hash = yl.search.serializeFilter(params)

yl.search.bindFilter = ()->
    # create cabins slider
    (()->
        select = $('#cabins-amount')
        min = parseInt($('#cabins-scale-min').html())
        max = parseInt($('#cabins-scale-max').html())
        slider = $('#cabins-slider').slider({
            min: min
            max: max
            range: 'min'
            value: min
            slide: (event, ui)->
                select.val(ui.value)
                yl.search.filterBoats('min_cabins')
        })
        select.change ()->
            slider.slider('value', this.value + min)
    )()

    # create age slider
    (()->
        select = $('#age-amount')
        min = parseInt($('#age-scale-min').html())
        max = parseInt($('#age-scale-max').html())
        slider = $('#age-slider').slider({
            min: min
            max: max
            range: 'min'
            value: max
            slide: (event, ui)->
                select.val(ui.value)
                yl.search.filterBoats('max_age')
        })
        select.change ()->
            slider.slider('value', this.value + min)
    )()

    # create length slider
    (()->
        select = $('#length-amount')
        min = parseInt($('#length-scale-min').html())
        max = parseInt($('#length-scale-max').html())
        slider = $('#length-slider').slider({
            min: min
            max: max
            range: 'min'
            value: min
            slide: (event, ui)->
                select.val(ui.value)
                yl.search.filterBoats('min_length')
        })
        select.change ()->
            slider.slider('value', this.value + min)
    )()

    $('#search-filter-form input[name=hull\\[\\]]').parent().change (eventObject)->
        yl.search.filterBoats('hull')
    $('#search-filter-form input[name=marina\\[\\]]').change (eventObject)->
        yl.search.filterBoats('marina')
    $('#search-filter-form input[name=model\\[\\]]').change (eventObject)->
        yl.search.filterBoats('model')
    $('#search-filter-form input[name=boat_attributes\\[\\]]').change (eventObject)->
        yl.search.filterBoats('boat_attributes')

yl.search.loadFilter = ()->
    hash = window.location.hash
    filter = yl.search.deserializeFilter(hash)
    
    if filter
        
        for elm in $('#search-filter-form input[name=hull\\[\\]]')
            if $(elm).val() in filter['hulls']
                $(elm).attr('checked', 'checked')
            else
                $(elm).removeAttr('checked')

        for elm in $('#search-filter-form input[name=marina\\[\\]]')
            if $(elm).val() in filter['marinas']
                $(elm).attr('checked', 'checked')
            else
                $(elm).removeAttr('checked')

        for elm in $('#search-filter-form input[name=boat_attributes\\[\\]]')
            if $(elm).val() in filter['boat_attributes']
                $(elm).attr('checked', 'checked')
            else
                $(elm).removeAttr('checked')

        for elm in $('#search-filter-form input[name=model\\[\\]]')
            if $(elm).val() in filter['models']
                $(elm).attr('checked', 'checked')
            else
                $(elm).removeAttr('checked')
        
        if filter['min_cabins'] != undefined
	        $('#cabins-amount').val( filter['min_cabins'] )
	        $('#cabins-slider').slider('value', filter['min_cabins'])

        if filter['max_age'] != undefined
          $('#age-amount').val( filter['max_age'] )
          $('#age-slider').slider('value', filter['max_age'])

        if filter['min_length'] != undefined
          $('#length-amount').val( filter['min_length'] )
          $('#length-slider').slider('value', filter['min_length'])

window.yl = yl


$(document).ready ()->
    yl.search.bindFilter()
    
    # load filter if hash bang is set
    yl.search.loadFilter()