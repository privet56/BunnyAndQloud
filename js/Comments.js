function getComments(token, listModel)
{
    var ajaxRequest = new XMLHttpRequest();
    ajaxRequest.onreadystatechange = function()
    {
        if(ajaxRequest.readyState === XMLHttpRequest.DONE)
        {
            var status = ajaxRequest.status;
            wait.visible = false;

            if (status !== 200)
            {
                messageDialog.informativeText = "The server returned an error while trying to log in: "+ajaxRequest.responseText;
                messageDialog.title = "Error "+status+" logging in...";
                messageDialog.visible = true;
                return;
            }
            var data = JSON.parse(ajaxRequest.responseText);
            if (data.message)
            {
                messageDialog.informativeText = "Error fetching the comments.\n"+data.message;
                messageDialog.title = "Error";
                messageDialog.visible = true;
                return;
            }

            data.sort(function(a, b){return a.date > b.date});

            for(var i=0;i<data.length;i++)
            {
                var o = {};
                o.avatar    = "../../res/comments.large.png";
                o.title     = data[i].username +  " " + (new Date(data[i].date));
                o.detail    = data[i].text;
                listModel.append(o);
            }
        }
    }
    var url="http://bunny-bunnyandcloud.rhcloud.com/api/comments?token="  + encodeURIComponent(token);
    ajaxRequest.open("GET", url, true);
    ajaxRequest.send(null);
}
