
function setCookie(name, value, day) {
    var d = new Date();
    d.setTime(d.getTime() + (day * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toGMTString();
    document.cookie = name + "=" + value + "; " + expires;
}

function getCookie(getName) {
    var name = getName + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i].trim();
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function clearCookieXSession() {
    setCookie("adminName","",0);
    setCookie("status","",0);
    sessionStorage.removeItem('adminName');
}

function checkLoginCookie1() {
    var adminName = getCookie("adminName");
    if(adminName != ""||adminName.length != 0||status!=0){
        window.location.href="zixishi";
        return;
    }
}
function checkLoginCookie2() {
    var adminName = getCookie("adminName");
    if(adminName == ""||adminName.length == 0){
        window.location.href="/";
        return;
    }
}

