// loading requirements
var firstPollDone = false;
var backgroundVideoLoaded = false;
var newDealVideoLoaded = false;
var minLoadingTimeDone = false;
var videosFailed = false;

//background video
var BV = {};
BV.BV = null;
BV.currentVideo = null;

$j(document).ready(function() {
    launch();
    setTimeout(refreshPage, 1000*60*60*24);

    $j(function() {
        setBackgroundVideo(BG_VIDEO_MP4, BG_VIDEO_OGV);
    });

    $j('.no_bookings_last_month .show_last_mo').click(function() {
        Visualforce.remoting.Manager.invokeAction(
            SET_LAST_MO_METHOD,
            true,
            function() {
                location.reload();
            });
    });

});

function launch() {
    // if both videos have loaded, we need a refresh so they don't freeze
    if (backgroundVideoLoaded && newDealVideoLoaded && !videosPreloaded()) {
        markVideosPreloaded();
        reload();
    }

    poll();
    setInterval(poll, POLL_INTERVAL);

    // make sure loading screen shows for visual aesthetic
    var minLoad = 2000;
    if (!videosPreloaded()) {
        minLoad = 0;
    }
    setTimeout(function() {
        minLoadingTimeDone = true
        checkDoneLoading();
    }, minLoad);
}

function checkDoneLoading() {
    if (videosFailed || (backgroundVideoLoaded && newDealVideoLoaded && firstPollDone && minLoadingTimeDone)) {
        if (!videosFailed && !videosPreloaded()) {
            markVideosPreloaded();
            reload();
        }
        else {
            var $spinner = $j('.spinner');
            $spinner.fadeOut(800, function() {
                $spinner.remove();
                setupControls();
                startBookingsChartSlideshow();
                startNewDealWatcher();
            });
        }
    }
}

function setupControls() {
    var hideControlsTimeout = null;
    var lockMouseMoveEvent = false;

    if (!$j('.warning_modal').is(':visible')) {
        hideControlsTimeout = setTimeout(function() {
            lockMouseMoveEvent = true;
            hideControls();
        }, 1000);
    }

    $j(window).mousemove(function(e) {
        if ($j('.warning_modal').is(':visible')) {
            lockMouseMoveEvent = false;
            showControls();
            clearTimeout(hideControlsTimeout);
            return true;
        }
        if (lockMouseMoveEvent) {
            lockMouseMoveEvent = false;
            return true;
        }
        if (e.pageY > 80) {
            if (hideControlsTimeout != null) {
                clearTimeout(hideControlsTimeout);
            }
            showControls()
            hideControlsTimeout = setTimeout(function() {
                lockMouseMoveEvent = true;
                hideControls();
            }, 1000);
        }
        else {
            if (hideControlsTimeout != null) {
                clearTimeout(hideControlsTimeout);
            }
        }
    });
}

function showControls() {
    $j('.controls_container .controls').addClass('visible');
    $j('.isfullscreen').removeClass('hide_mouse');
}

function hideControls() {
    $j('.controls_container .controls').removeClass('visible');
    $j('.isfullscreen').addClass('hide_mouse');
}

function reload() {
    location.reload();
}

function setBackgroundVideo(video, altSource) {
    if (!BV.BV) {
        BV.BV = new $j.BigVideo({useFlashForFirefox:false});
        BV.BV.init();

        BV.BV.getPlayer().on('canplaythrough', function() {
            if (!backgroundVideoLoaded) {
                backgroundVideoLoaded = true;
                setBackgroundVideo(NEW_DEAL_MP4, NEW_DEAL_OGV);
            }
            else if (!newDealVideoLoaded) {
                newDealVideoLoaded = true;
                setBackgroundVideo(BG_VIDEO_MP4, BG_VIDEO_OGV);
                checkDoneLoading();
            }
        });

        BV.BV.getPlayer().on('error', function(event) {
        	videosFailed = true;
        	checkDoneLoading();
        });
    }
    if (BV.currentVideo != video) {
        BV.currentVideo = video;
        BV.BV.show([
                { type: "video/mp4",  src: video },
                { type: "video/ogg",  src: altSource }
            ], { ambient:true });
    }
}

function videosPreloaded() {
    return typeof($j.cookie("videosLoaded")) !== "undefined";
}

function markVideosPreloaded() {
    $j.cookie("videosLoaded", "yes");
}

function hideScreen() {
    if (typeof(BV.BV) !== "undefined") {
        BV.BV.getPlayer().pause();
    }
    $j('.slide-container').hide(0);
    $j('.ticker_component').hide(0);
}

function showScreen(callback) {
    if (typeof(BV.BV) !== "undefined") {
        BV.BV.getPlayer().play();
    }
    $j('.slide-container').show(0, function() {
        $j('.ticker_component').show(0, function() {
            if (typeof(callback) === "function") {
                callback();
            }
        });
    });
}

function refreshPage() {
    if ($j('.newdeal_component .new_deals .new_deal').length === 0) {
        location.reload();
    }
    else {
        setTimeout(refreshPage, 1000*60*5);
    }
}

function poll() {
    Visualforce.remoting.Manager.invokeAction(
        REMOTE_POLL_METHOD,
        pollResponse
    );
}

function pollResponse(result, event) {
    if (event.status) {
        if (result.Error[0]) {
            $j('.warning_modal.invalid_field').fadeIn();
        }
        else if ($j('.warning_modal.invalid_field').is(':visible')) {
            $j('.warning_modal.invalid_field').fadeOut();
        }

        //console.log(result);

        var hasBookingsThisMonth = result.HasBookingsThisMonth[0];
        var timePeriod = result.TimePeriod[0];
        var showLastPeriod = result.ShowLastPeriod[0];
        var totalBookingsThisPeriod = result.TotalBookingsThisPeriod[0];

        bookingsByEmpPollResponse(result.BookingsByEmp, 
                                  timePeriod, 
                                  showLastPeriod, 
                                  hasBookingsThisMonth,
                                  totalBookingsThisPeriod);
        tickerPollResponse(result.Ticker);
        newDealPollResponse(result.NewDeals);

        firstPollDone = true;
        checkDoneLoading();
    }
    else if (event.type === 'exception') {
        location.reload();
    }
    else {
        $j('.warning_modal.unknown_error').fadeIn();
    }
}

