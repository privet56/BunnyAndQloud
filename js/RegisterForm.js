
function onTextFieldChanged()
{
    hint.text = "";

    if((inputName.text.trim() == '') ||
       (inputUsername.text.trim() == '') ||
       (inputPassword.text.trim() == '') ||
       (inputPasswordRetype.text.trim() == ''))
    {
        bRegister.enabled = false;
        return;
    }

    if(inputPassword.text != inputPasswordRetype.text)
    {
        bRegister.enabled = false;
        hint.text = "Passwords are not same.";
        return;
    }

    bRegister.enabled = true;
}
function doregister()
{
    var ajaxRequest = new XMLHttpRequest();
    ajaxRequest.onreadystatechange = function()
    {
        if(ajaxRequest.readyState === XMLHttpRequest.DONE)
        {
            var status = ajaxRequest.status;

            if (status !== 200)
            {
                messageDialog.informativeText = "The server returned an error: "+ajaxRequest.responseText;
                messageDialog.title = "Error "+status;
                messageDialog.visible = true;
                return;
            }

            var resjson = JSON.parse(ajaxRequest.responseText);
            if(!resjson.success)
            {
                messageDialog.informativeText = resjson.message;
                messageDialog.title = "Success!";
                messageDialog.visible = true;
                return;
            }

            hint.text = resjson.message;
            bRegister.visible = false;
        }
    }
    var params =
            "type=create"   +
            "&name="        + encodeURIComponent(inputName.text.trim()) +
            "&username="    + encodeURIComponent(inputUsername.text.trim()) +
            "&password="    + encodeURIComponent(inputPassword.text.trim());

    var url="http://bunny-bunnyandcloud.rhcloud.com/api/users";

    ajaxRequest.open("POST", url, true);
    ajaxRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajaxRequest.setRequestHeader("Content-length", params.length);
    ajaxRequest.setRequestHeader("Connection", "close");
    ajaxRequest.send(params);
}
