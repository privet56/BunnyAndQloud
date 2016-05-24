function getFans(token, listModel)
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
                messageDialog.informativeText = "Error fetching the fans.\n"+data.message;
                messageDialog.title = "Error";
                messageDialog.visible = true;
                return;
            }

            data.sort(function(a, b){return a.username > b.username});

            for(var i=0;i<data.length;i++)
            {
                var o = {};
                o.avatar    = "../../res/user_blue.png";
                o.title     = data[i].username;
                o.detail    = data[i].name + (data[i].lastplay ? "  (last played: "+(new Date(data[i].lastplay))+")" : "");
                listModel.append(o);
            }
        }
    }
    var url="http://bunny-bunnyandcloud.rhcloud.com/api/users?token="  + encodeURIComponent(token);
    ajaxRequest.open("GET", url, true);
    ajaxRequest.send(null);
}
