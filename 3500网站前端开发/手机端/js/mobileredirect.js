function redirectByDevice() {

    var path = window.location.pathname.toUpperCase();

    if (screen.width <= 800) {
        if (!path.startsWith("/MOBILE") && window.location.search.search(/WAP=FALSE/i) < 0) {
            var newPath = "/Mobile" + window.location.pathname + window.location.search;
            window.location = newPath;
        }
    }
    else {
        if (path.startsWith("/MOBILE") && window.location.search.search(/WAP=TRUE/i) < 0) {
            var newPath = (window.location.pathname + window.location.search).substring(7);
            if (newPath == "")
                newPath = "/";
            window.location = newPath;
        }
    }
}

redirectByDevice();

