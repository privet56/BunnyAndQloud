String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g, '');};

function main()
{

}
function metaData2Text(o)
{
    if(!o)return null;
    var s = "";
    for(var d in o)
    {
        if(arguments.length > 1)
        {
            var bAttr2Print = false;
            for(var i=1;i<arguments.length;i++)
            {
                if(arguments[i] == d)
                {
                    bAttr2Print = true;
                    break;
                }
            }
            if(!bAttr2Print)continue;
        }

        s += d+": "+o[d] + "\n";
    }
    return s;
}

function onPop(stackView)
{
    //stackView.depth
}
