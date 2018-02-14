var imageAddr = "/assets/logo.png" + "?n=" + Math.random();
var startTime, endTime;
var downloadSize = [15449];
var download = new Image();
download.onload = function () {
    endTime = (new Date()).getTime();
    showResults();
}
startTime = (new Date()).getTime();
download.src = imageAddr;

function showResults() {
    var duration = (endTime - startTime) / 1000;
    var bitsLoaded = downloadSize * 8;
    var speedBps = (bitsLoaded / duration).toFixed(2);
    var speedKbps = (speedBps / 1024).toFixed(2);
    var speedMbps = (speedKbps / 1024).toFixed(2);
    
    $("#connection_info").html("<li class='sub_header'> Your connection speed: </li>" + 
                                  "<li>" + "<h6>In bps</h6>: "  + speedBps  + "</li>" + 
                                  "<li>" + "<h6>In kbps</h6>: " + speedKbps + "</li>" + 
                                  "<li>" + "<h6>In mbps</h6>: " + speedMbps + "</li>");
}