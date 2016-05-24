String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g, '');};

function search4Bunnies(coord/*has latitude + longitude*/, mapComponent)
{
    if(!coord || !coord.latitude)
    {
        console.log("search4Bunnies WRN: !coord:"+coord);
        return "";
    }
    if(!mapComponent)
    {
        console.log("search4Bunnies WRN: !map:"+mapComponent);
        return "";
    }

//https://www.flickr.com/services/api/flickr.photos.search.html
//maybe with bbox?

    var source = "https://api.flickr.com/services/rest/?" +
            //"min_taken_date="+getTodayAsString()+"&" +
            "extras=date_taken&" +
            "tags=bunny,bunnies,hase,hasen,rabbits,rabbit&" +
            "method=flickr.photos.search&" +
            "per_page=99&" +
            "sort=date-taken-desc&" +
            "format=json&" +
            "dataType=json&" +
            "jsonpCallback=jsonFlickrApi&"+
            "api_key=e36784df8a03fea04c22ed93318b291c&" +
            "has_geo=1&" +
            "extras=geo,url_m&radius=20&radius_units=mi&" +
            "lat=" + coord.latitude + "&lon=" + coord.longitude;

    //console.log(source);
    fetchPics(source, mapComponent);
    return source;
}

function fetchPics(url, mapComponent)
{
    var ajaxRequest = new XMLHttpRequest();
    ajaxRequest.onreadystatechange = function()
    {
        if(ajaxRequest.readyState === XMLHttpRequest.DONE)
        {
            var status = ajaxRequest.status;

            if (status !== 200)
            {
                msgs.text = "The server returned an error "+status+" while trying to search: "+ajaxRequest.responseText;
                return;
            }

            var s = ajaxRequest.responseText.substring(ajaxRequest.responseText.indexOf('(')+1, ajaxRequest.responseText.length - 1);
//console.log("HIST:-----------------\n"+s+"\n----------------------------------");
            var json = JSON.parse(s);

            var photos = [];
            for(var i=0;i<json.photos.photo.length;i++)
            {
                var tt = json.photos.photo[i].title.toLowerCase();
                if((tt.indexOf('bunn') < 0) && (tt.indexOf('hase') < 0) && (tt.indexOf('rabbit') < 0) && (tt.indexOf('ny') < 0))
                {
                    continue;
                }
                photos.push(json.photos.photo[i]);
            }

            if( photos.length < 1)
                photos = json.photos.photo;

console.log("hitcount:"+json.photos.photo.length+" --> "+photos.length);

            if(photos.length < 1)
            {
                msgs.text = "No bunny photos found nearby...";
                return;
            }

            mapComponent.deleteMarkers();

            for(var i=0;i<photos.length;i++)
            {
                fetchPic( photos[i], photos, mapComponent);
            }
        }
    }

    ajaxRequest.open("GET", url, true);
    ajaxRequest.send(null);
}

function onPicDblClick(imgSrc, metaData)
{
    var page = Qt.resolvedUrl("../BunnyImg.qml")
    page.src = imgSrc
    stackView.push(page, {src:imgSrc, metaData:metaData})
    titleBar.title = metaData.title
}

function insertPic2Map(photo, photos, mapComponent)
{
    for(var i=0;i<photos.length;i++)
    {
        if(photos[i] === photo)continue;
        if(photos[i].longitude === photo.longitude && photos[i].latitude === photo.latitude)
        {
            return; //do not use pics at the same loc
        }
    }

    //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    var imgUrl = photo.url_m ? photo.url_m : "https://farm"+photo.farm+".staticflickr.com/"+photo.server+"/"+photo.id+"_"+photo.secret+".jpg";
    var markerPos = null;//mapComponent.addMarkerAtPos(photo.longitude, photo.latitude, photo);
    mapComponent.addImgGeoItemAtPos("ImageItem", markerPos, imgUrl, photo, onPicDblClick, photo.longitude, photo.latitude);

    //console.log("photo:"+photo.id+" loc:"+json.photo.location.longitude + " <> "+ json.photo.location.latitude);
}

function fetchPic(photo, photos, mapComponent)
{
    if(photo.longitude && photo.latitude)
    {
        insertPic2Map(photo, photos, mapComponent);
        return;
    }
console.log("second call necessary ... :-(");
    var url = "https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=e36784df8a03fea04c22ed93318b291c&photo_id="+photo.id+"&format=json&nojsoncallback=1";
    var ajaxRequest = new XMLHttpRequest();
    ajaxRequest.onreadystatechange = function()
    {
        if(ajaxRequest.readyState === XMLHttpRequest.DONE)
        {
            var status = ajaxRequest.status;

            if (status !== 200)
            {
                console.log("The server returned an error "+status+" while trying to get location: "+ajaxRequest.responseText+"\n"+url);
                return;
            }
            var s = ajaxRequest.responseText;
            var json = JSON.parse(s);
            photo.longitude = json.photo.location.longitude;
            photo.latitude  = json.photo.location.latitude;

            insertPic2Map(photo, photos, mapComponent);
        }
    }
//api_key:f8744b702f07fa11a59b9fec82ead4b3
//api_key:e36784df8a03fea04c22ed93318b291c

    ajaxRequest.open("GET", url, true);
    ajaxRequest.send(null);
}

function getTodayAsString()
{
    //example: 2000-01-01+0:00:00
    var d = new Date();
    var s = d.getFullYear()+"-"+pad(d.getMonth()/*+1*/, 2)+"-"+pad(d.getDate(), 2)+"+0:00:00";
    return s;
}
function pad(s, padTo)
{
    s = ""+s;
    while(s.length < padTo)
        s = "0"+s;
    return s;
}
