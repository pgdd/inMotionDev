
map = undefined
codeAddress = undefined
geocoder = undefined
yellowMarker = '/images/yellow_MarkerA.png'
blueMarker = '/images/blue_MarkerA.png'
currentPosMarker = undefined
currentPosInfowindow = undefined
lastClickedMarker = undefined
lastClickedInfowindow = undefined
currentFindMarker = undefined
currentFindInfowindow = undefined
array = undefined
marker = undefined



Template.map.rendered = ->
  google.maps.event.addDomListener(window, 'load', initialize);
  initialize()
  geoLocation()
  autorunPinOnMap()


initialize = ->
  geocoder = new google.maps.Geocoder()
  mapOptions =
    zoom: 8
    # center: new google.maps.LatLng(-34.397, 150.644)

  mapDiv = document.getElementById("map-canvas")
  map = new google.maps.Map(mapDiv, mapOptions)
  pinMarker()

pinMarker = ->
  google.maps.event.addListener map, "click", (event) ->
    console.log latt = event.latLng.lat()
    console.log long = event.latLng.lng()
    # console.log a = $("button#createMarker").data("lat")
    # console.log a
    if $("button#createMarker").data("lat") == undefined
      $("button#createMarker").data("lat", latt)
      $("button#createMarker").data("long", long)
      console.log $("button#createMarker").data("lat")
      contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div>" + "<h1 id=\"firstHeading\" class=\"firstHeading\">Uluru</h1>" + "<div id=\"bodyContent\">" + "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " + "sandstone rock formation in the southern part of the " + "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " + "south west of the nearest large town, Alice Springs; 450&#160;km " + "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " + "features of the Uluru - Kata Tjuta National Park. Uluru is " + "sacred to the Pitjantjatjara and Yankunytjatjara, the " + "Aboriginal people of the area. It has many springs, waterholes, " + "rock caves and ancient paintings. Uluru is listed as a World " + "Heritage Site.</p>" + "<p>Attribution: Uluru, <a href=\"http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194\">" + "http://en.wikipedia.org/w/index.php?title=Uluru</a> " + "(last visited June 22, 2009).</p>" + "</div>" + "</div>"
      lastClickedInfowindow = new google.maps.InfoWindow(content: contentString)
      lastClickedMarker = new google.maps.Marker(
        position:
          lat: latt,
          lng: long,

        map: map,
        draggable:true,
        icon: blueMarker

        )
      # arrayMarked.push lastClickedMarker
      google.maps.event.addListener lastClickedMarker, "click", ->

        lastClickedInfowindow.open map, lastClickedMarker
        currentPosInfowindow.close map, currentPosMarker
        if currentFindInfowindow == undefined
          return
        else currentFindInfowindow.close map, currentFindMarker

    else if $("button#createMarker").data("lat") isnt undefined
      lastClickedMarker.setMap(null)
      $("button#createMarker").data("lat", latt)
      $("button#createMarker").data("long", long)
      console.log $("button#createMarker").data("lat")
      contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div>" + "<h1 id=\"firstHeading\" class=\"firstHeading\">Uluru</h1>" + "<div id=\"bodyContent\">" + "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " + "sandstone rock formation in the southern part of the " + "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " + "south west of the nearest large town, Alice Springs; 450&#160;km " + "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " + "features of the Uluru - Kata Tjuta National Park. Uluru is " + "sacred to the Pitjantjatjara and Yankunytjatjara, the " + "Aboriginal people of the area. It has many springs, waterholes, " + "rock caves and ancient paintings. Uluru is listed as a World " + "Heritage Site.</p>" + "<p>Attribution: Uluru, <a href=\"http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194\">" + "http://en.wikipedia.org/w/index.php?title=Uluru</a> " + "(last visited June 22, 2009).</p>" + "</div>" + "</div>"
      lastClickedInfowindow = new google.maps.InfoWindow(content: contentString)
      lastClickedMarker = new google.maps.Marker(
        position:
          lat: latt,
          lng: long,

        map: map,
        draggable:true,
        icon: blueMarker

        )
      # arrayMarked.push lastClickedMarker
      google.maps.event.addListener lastClickedMarker, "click", ->
        # console.log event.latLng
        lastClickedInfowindow.open map, lastClickedMarker
        currentPosInfowindow.close map, currentPosMarker
        if currentFindInfowindow == undefined
          return
        else currentFindInfowindow.close map, currentFindMarker


autorunPinOnMap = ->
  Meteor.subscribe('markers')
  if (Meteor.isClient)
      Deps.autorun () ->
      # \Print the marker on the map from database, on launch, and each time collection Markers is touched
        array = Markers.find().fetch()
        console.log array
        for key, object of array
          console.log key
          latt = object.lat
          long = object.lng
      # \Each marker will include an InfoWindow on click, with a defined content
          contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div>" + "<h1 id=\"firstHeading\" class=\"firstHeading\">Uluru</h1>" + "<div id=\"bodyContent\">" + "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " + "sandstone rock formation in the southern part of the " + "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " + "south west of the nearest large town, Alice Springs; 450&#160;km " + "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " + "features of the Uluru - Kata Tjuta National Park. Uluru is " + "sacred to the Pitjantjatjara and Yankunytjatjara, the " + "Aboriginal people of the area. It has many springs, waterholes, " + "rock caves and ancient paintings. Uluru is listed as a World " + "Heritage Site.</p>" + "<p>Attribution: Uluru, <a href=\"http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194\">" + "http://en.wikipedia.org/w/index.php?title=Uluru</a> " + "(last visited June 22, 2009).</p>" + "</div>" + "</div>"
          infowindow = new google.maps.InfoWindow(content: contentString)
          marker = new google.maps.Marker
            position:
              lat: latt,
              lng: long,
            map: map,
            draggable:true,

          # arrayMarked.push @
        # \Here is the part to associate the right click  to the right marker to the right window.
          google.maps.event.addListener marker , "click", (event) ->
            infowindow.open map, this
            # return
            # # console.log arrayMarked

            # # closeAll()
            if currentPosInfowindow is undefined
              currentFindInfowindow.close map, currentFindMarker
              lastClickedInfowindow.close map, lastClickedMarker
            else if  currentPosInfowindow isnt undefined
              currentPosInfowindow.close map, currentPosMarker
              currentFindInfowindow.close map, currentFindMarker
              lastClickedInfowindow.close map, lastClickedMarker

            if currentFindInfowindow is undefined
              currentPosInfowindow.close map, currentPosMarker
              lastClickedInfowindow.close map, lastClickedMarker
            else if currentFindInfowindow isnt undefined
              currentPosInfowindow.close map, currentPosMarker
              currentFindInfowindow.close map, currentFindMarker
              lastClickedInfowindow.close map, lastClickedMarker

            if lastClickedInfowindow is undefined
              currentPosInfowindow.close map, currentPosMarker
              currentFindInfowindow.close map, currentFindMarker
            else if lastClickedInfowindow isnt undefined
              currentPosInfowindow.close map, currentPosMarker
              currentFindInfowindow.close map, currentFindMarker
              lastClickedInfowindow.close map, lastClickedMarker



          console.log 'one new pin from DB has been made'


geoLocation = ->
  if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((position) ->
        pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div>" + "<h1 id=\"firstHeading\" class=\"firstHeading\">Uluru</h1>" + "<div id=\"bodyContent\">" + "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " + "sandstone rock formation in the southern part of the " + "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " + "south west of the nearest large town, Alice Springs; 450&#160;km " + "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " + "features of the Uluru - Kata Tjuta National Park. Uluru is " + "sacred to the Pitjantjatjara and Yankunytjatjara, the " + "Aboriginal people of the area. It has many springs, waterholes, " + "rock caves and ancient paintings. Uluru is listed as a World " + "Heritage Site.</p>" + "<p>Attribution: Uluru, <a href=\"http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194\">" + "http://en.wikipedia.org/w/index.php?title=Uluru</a> " + "(last visited June 22, 2009).</p>" + "</div>" + "</div>"
        currentPosInfowindow = new google.maps.InfoWindow(content: contentString)
        currentPosMarker = new google.maps.Marker
          map: map,
          position: pos,
          icon: yellowMarker
          zoom: 13
        # arrayMarked.push currentPosMarker
        google.maps.event.addListener currentPosMarker, "click", ->
          latitude = this.position.lat()
          longitude = this.position.lng()
          $("button#createMarker").data("lastlat", latitude)
          $("button#createMarker").data("lastlong", longitude)
          currentPosInfowindow.open map, currentPosMarker
          # console.log arrayMarked
          if lastClickedInfowindow == undefined
            currentFindInfowindow.close map, currentFindMarker
            infowindow.close map, marker
          else if lastClickedInfowindow isnt undefined
            lastClickedInfowindow.close map, lastClickedMarker
            currentFindInfowindow.close map, currentFindMarker
            infowindow.close map, marker
        map.setCenter pos), ->
        handleNoGeolocation true
    else
      handleNoGeolocation false
# closeAll = ->
#   i = 0

#   while i < infoWindows.length
#     infoWindows[i].close()
#     i++
#   return

handleNoGeolocation = (errorFlag) ->
  if errorFlag
    content = "Error: The Geolocation service failed."
  else
    content = "Error: Your browser doesn't support geolocation."
  options =
    map: map
    position: new google.maps.LatLng(60, 105)
    content: content

  infowindow = new google.maps.InfoWindow(options)
  map.setCenter options.position
  addMarker(position, map)

insertMarkersInDb =  ->
  Template.editMarker.events
    "click button#createMarker" : (e, t) ->
      console.log latData = $("button#createMarker").data("lat")
      console.log longData = $("button#createMarker").data("long")
      Markers.insert(markerObjectForm(latData, longData))
insertMarkersInDb()

markerObjectForm =  (latData, longData) ->
      {lat: latData, lng: longData}

findOnMap = ->
  Template.map.events
    "click button#address" : (e, t) ->
      address = document.getElementById("address").value
      geocoder.geocode
        address: address
      , (results, status) ->
        if status is google.maps.GeocoderStatus.OK
          map.setCenter results[0].geometry.location
          contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div>" + "<h1 id=\"firstHeading\" class=\"firstHeading\">Uluru</h1>" + "<div id=\"bodyContent\">" + "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " + "sandstone rock formation in the southern part of the " + "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " + "south west of the nearest large town, Alice Springs; 450&#160;km " + "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " + "features of the Uluru - Kata Tjuta National Park. Uluru is " + "sacred to the Pitjantjatjara and Yankunytjatjara, the " + "Aboriginal people of the area. It has many springs, waterholes, " + "rock caves and ancient paintings. Uluru is listed as a World " + "Heritage Site.</p>" + "<p>Attribution: Uluru, <a href=\"http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194\">" + "http://en.wikipedia.org/w/index.php?title=Uluru</a> " + "(last visited June 22, 2009).</p>" + "</div>" + "</div>"
          currentFindInfowindow = new google.maps.InfoWindow(content: contentString)
          currentFindMarker = new google.maps.Marker(
            map: map
            draggable:true,
            position: results[0].geometry.location
          )
          # arrayMarked.push currentFindMarker
          google.maps.event.addListener currentFindMarker, "click", ->
            currentFindInfowindow.open map, currentFindMarker
            currentPosInfowindow.close map, currentPosMarker
            lastClickedInfowindow.close map, lastClickedMarker
          # closeAll()

        else
          alert "Geocode was not successful for the following reason: " + status
        return
      return
      e.preventDefault()
      false
findOnMap()

# console.log arrayMarked


