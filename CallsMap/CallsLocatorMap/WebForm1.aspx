<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="CallsLocatorMap.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LeafetMap</title>
    <link rel="stylesheet" href="C:/Users/Radostina/Desktop/CallsMap/leaflet.css" />
    <script type='text/javascript' src='C:/Users/Radostina/Desktop/CallsMap/packages/jQuery.3.0.0/Content/Scripts/jquery.min.js'></script>
    <script type='text/javascript' src='C:/Users/Radostina/Desktop/CallsMap/leaflet.js'></script>
</head>
<body>
    <h1>Map of calls near Bratislava</h1>
    <div id="map" style="width: 800px; height: 440px; border: 1px solid #AAA;"></div>
    <script src="C:/Users/Radostina/Desktop/CallsMap/leaflet.js.map"></script>
</body>
    <script>
        var mylat = '50.58007';
        var mylong = '-3.75578';
        var myzoom = '10';
        var map = L.map('map').setView([mylat, mylong], myzoom);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 17,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        L.marker([mylat, mylong]).addTo(map).bindPopup("<b>This is Haytor!</b>").openPopup();
        L.circle([mylat, mylong], 500, {
            color: 'red',
            fillColor: '#f2d5df',
            fillOpacity: 0.2
        }).addTo(map).bindPopup("");

        markers = [{
            "name": "Supermarket",
            "url": "",
            "lat": 50.54086,
            "lng": -3.60219
        }, {
            "name": "Information Centre",
            "url": "http://www.dartmoor.gov.uk/",
            "lat": 50.58093,
            "lng": -3.7453
        }];
        for (var i = 0; i < markers.length; ++i) {
            L.marker([markers[i].lat, markers[i].lng], {
                icon: new L.DivIcon({
                    className: 'my-div-icon',
                    html: '<span class="my-map-label">' + markers[i].name + '</span>'
                })
            }).addTo(map);

            L.marker([markers[i].lat, markers[i].lng]).addTo(map).bindPopup(markers[i].name);
        }
    </script>
</html>
        <div class="row">
            <div class="col-25">
                <label for="country">Select customers by their age.</label>
            </div>
            <div class="col-75">
                <select id="age" name="age">
                    <option value="firstGroup">1-18</option>
                    <option value="secondGroup">19-25</option>
                    <option value="thirdGroup">26-35</option>
                    <option value="fourthGroup">36-45</option>
                    <option value="fifthGroup">46-65</option>
                    <option value="sixthhGroup">66-100</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-25">
                <label for="country">Select gender:</label>
            </div>
            <div class="col-75">
                <select id="gender" name="gender">
                    <option value="firstGroup">M</option>
                    <option value="secondGroup">F</option>
                </select>
            </div>
        </div>
