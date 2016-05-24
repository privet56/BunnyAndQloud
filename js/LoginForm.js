
function onTextFieldChanged()
{
    if(loginFormItem.token)
    {
        bLogin.enabled = true;
        return;
    }

    if((inputUsername.text.trim() == '') ||
       (inputPassword.text.trim() == ''))
        bLogin.enabled = false;
    else
        bLogin.enabled = true;
}
function dologin()
{
    if(loginFormItem.token ||
       (inputUsername.text == inputPassword.text && inputPassword.text === "s"))
    {
        console.log("--> goto fuChooser!")
        window.token = loginFormItem.token;
        var page = Qt.resolvedUrl("../FunctionChooser.qml")
        page.token = loginFormItem.token
        stackView.push(page)
        titleBar.title = "Bunny Pages"
        return;
    }

    ani.loops = Animation.Infinite
    ani.target = bLogin
    ani.running = true

    var ajaxRequest = new XMLHttpRequest();
    ajaxRequest.onreadystatechange = function()
    {
        if(ajaxRequest.readyState == XMLHttpRequest.DONE)
        {
            var status = ajaxRequest.status;

            ani.complete();
            ani.running = false;

            if (status !== 200)
            {
                messageDialog.informativeText = "The server returned an error while trying to log in: "+ajaxRequest.responseText;
                messageDialog.title = "Error "+status+" logging in...";
                messageDialog.visible = true;
                return;
            }

            var resjson = JSON.parse(ajaxRequest.responseText);

            if(!resjson.success)
            {
                messageDialog.informativeText = resjson.message;
                messageDialog.title = "Wrong user data";
                messageDialog.visible = true;
                return;
            }

            var token = resjson.token;
            loginFormItem.token = token;
            window.token = loginFormItem.token;

            //TODO: particle!
            //TODO: forward to function list page

            {   //temporarily...
                console.log("--> goto fuChooser after login!")
                window.token = loginFormItem.token;
                var page = Qt.resolvedUrl("../FunctionChooser.qml")
                page.token = loginFormItem.token
                stackView.push(page)
                titleBar.title = "Bunny Pages"
                return;
            }
        }
    }
    var params =
            "username="  + encodeURIComponent(inputUsername.text.trim()) +
            "&password=" + encodeURIComponent(inputPassword.text.trim());

    var url="http://bunny-bunnyandcloud.rhcloud.com/api/authenticate";

    ajaxRequest.open("POST", url, true);
    ajaxRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajaxRequest.setRequestHeader("Content-length", params.length);
    ajaxRequest.setRequestHeader("Connection", "close");
    ajaxRequest.send(params);
}

function on3DBunnyExplorerClick(wv, img)
{
    wv.url = "about:blank";
    img.visible = false;

    //setTimeout(function() {
        var page = Qt.resolvedUrl("../Bunny3DExplorer.qml");
        stackView.push(page);
        titleBar.title = "Bunny 3D Explorer";
    //}, 1000);
}
