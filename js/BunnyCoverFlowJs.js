//TODO: impl + call bunny service!

function getpics(len)
{
    var a = [];
    for(var i=1;i<=len;i++)
    {
        var s = ""+i+"";
        while(s.length < 2) s = "0"+s;
        a.push(s);
    }
    return a;
};

var themes = [
{
    name: "home",
    carouselIndex:0,
    _pics: getpics(12),
    pics: function()
    {
        return this._pics;
    }
},
{
    name: "winter",
    carouselIndex:0,
    _pics: getpics(7),
    pics: function()
    {
        return this._pics;
    }
},
{
    name: "spring",
    carouselIndex:0,
    _pics: getpics(4),
    pics: function()
    {
        return this._pics;
    }
},
{
    name: "summer",
    carouselIndex:0,
    _pics: getpics(4),
    pics: function()
    {
        return this._pics;
    }
}];

function bunnyImages()
{
    var a = [];
    for(var i=0;i<themes.length;i++)
    {
        var aPicIndexes = themes[i].pics();

        for(var i2=0; i2 < aPicIndexes.length; i2++)
        {
            a.push({theme:themes[i].name, idx:aPicIndexes[i2], src:"http://bunny-bunnyandcloud.rhcloud.com/assets/img/bunny/"+themes[i].name+""+aPicIndexes[i2]+".png"});
        }
    }
    return a;
}
