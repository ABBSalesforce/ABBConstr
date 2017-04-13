function createChartRow(employee, rowNum, maxBooked) {
    var barWidth = employee.booked / maxBooked * 95;
    var html = '';
    html += '<li class="item row'+rowNum+'">';
    html += '  <span class="highlight"></span>';
    html += '  <h2 class="label">'+employee.name+'</h2>';
    html += '  <div class="bar_container">';
    html += '    <div class="bar" style="width:'+barWidth+'%">';
    html += '      <span class="value">'+employee.bookedStr+'</span>';
    html += '    </div>';
    html += '  </div>';
    html += '</li>';

    return html;
}

// for testing only
function createChartRows() {
    var html = '';

    html += '<li class="item row1">';
    html += '  <span class="highlight"></span>';
    html += '  <h2 class="label">Cat A.</h2>';
    html += '  <div class="bar_container">';
    html += '    <div class="bar" style="width:100%">';
    html += '      <span class="value">$10K</span>';
    html += '    </div>';
    html += '  </div>';
    html += '</li>';

    html += '<li class="item row2">';
    html += '  <span class="highlight"></span>';
    html += '  <h2 class="label">Dog B.</h2>';
    html += '  <div class="bar_container">';
    html += '    <div class="bar" style="width:80%">';
    html += '      <span class="value">$8K</span>';
    html += '    </div>';
    html += '  </div>';
    html += '</li>';

    html += '<li class="item row3">';
    html += '  <span class="highlight"></span>';
    html += '  <h2 class="label">Giraffe C.</h2>';
    html += '  <div class="bar_container">';
    html += '    <div class="bar" style="width:50%">';
    html += '      <span class="value">$5K</span>';
    html += '    </div>';
    html += '  </div>';
    html += '</li>';

    html += '<li class="item row4">';
    html += '  <span class="highlight"></span>';
    html += '  <h2 class="label">Platypus D.</h2>';
    html += '  <div class="bar_container">';
    html += '    <div class="bar" style="width:20%">';
    html += '      <span class="value">$2K</span>';
    html += '    </div>';
    html += '  </div>';
    html += '</li>';

    html += '<li class="item row5">';
    html += '  <span class="highlight"></span>';
    html += '  <h2 class="label">Ostrich E.</h2>';
    html += '  <div class="bar_container">';
    html += '    <div class="bar" style="width:5%">';
    html += '      <span class="value">$500</span>';
    html += '    </div>';
    html += '  </div>';
    html += '</li>';

    return html;
}

function createDetailBox(employee, rowNum) {
    var html = '';
    html += '<div class="detail row'+rowNum+'">';
    html += '  <div class="header">';
    html += '    <span class="vertical_aligner"></span>';
    html += '    <div class="avatar_container">';
    html += '      <img class="avatar" src="'+employee.imgUrl+'" onload="handleResize();" />';
    html += '    </div>';
    html += '    <div class="name_container">';
    html += '      <span class="vertical_aligner"></span>';
    html += '      <h2 class="name">'+employee.fullName+'</h2>';
    html += '    </div>';
    html += '  </div>';
    html += '  <ul class="content">';
    html += '    <li class="item stat row1">';
    html += '      <span class="vertical_aligner"></span>';
    html += '      <span class="number">'+employee.dealCount+'</span>';
    html += '      <span class="unit">deals</span>';
    html += '    </li>';
    html += '    <li class="item stat row2">';
    html += '      <span class="vertical_aligner"></span>';
    html += '      <span class="number">'+employee.avgSellingPriceStr+'</span>';
    html += '      <span class="unit">avg. value</span>';
    html += '    </li>';
    html += '    <li class="item stat row3">';
    html += '      <span class="vertical_aligner"></span>';
    html += '      <span class="number">'+employee.avgSalesCycle+' days</span>';
    html += '      <span class="unit">sales cycle</span>';
    html += '    </li>';
    html += '  </ul>';
    html += '</div>';
    return html;
}

function addEmployees(employees) {
    var chartRows = "";
    var detailBoxes = "";
    for (var i=0; i < employees.length; i++) {
        var employee = employees[i];
        chartRows += createChartRow(employee, i+1, employees[0].booked);
        detailBoxes += createDetailBox(employee, i+1);
    }

    $j('.chart').html(chartRows);
    //$j('.chart').html(createChartRows()); // for testing only
    $j('.details').html(detailBoxes);

    scaleChart();
}

function setupSlideshow(numRows) {
    var VISIBLE_TIME = 7000;

    for (var i=0; i < numRows; i++) {
        (function () {
            var rowNum = i+1;
            var $chartHighlight = $j('.chart .item.row'+rowNum+' .highlight');
            var $detailContainer = $j('.details .detail.row'+rowNum);
            var startTime = i*VISIBLE_TIME;
            var cycleTime = numRows*VISIBLE_TIME;

            // show row
            setTimeout(function() {
                $chartHighlight.addClass('show');
                $detailContainer.addClass('show');

                if (numRows > 1) {

                    // when to show row next
                    setInterval(function() {
                        $chartHighlight.addClass('show');
                        $detailContainer.addClass('show');
                    }, cycleTime);

                    // hide row
                    setTimeout(function() {
                        $chartHighlight.removeClass('show');
                        $detailContainer.removeClass('show');

                        // when to hide row next
                        setInterval(function() {
                            $chartHighlight.removeClass('show');
                            $detailContainer.removeClass('show');
                        }, cycleTime);

                    }, VISIBLE_TIME);
                }

            }, startTime);
        })();
    }
}

function removeNoBookingsMessage() {
    $j('.bookings_component .body .no_bookings_container').remove();
}

function changeHeader(thisOrLast, timePeriod) {
    $j('.bookings_component .title').html('top reps '+thisOrLast+' '+timePeriod);
}

function changeMessage(thisOrLast, timePeriod) {
    $j('.no_bookings .no_bookings_msg').html('Oh no! Zero bookings '+thisOrLast+' '+timePeriod);
    $j('.no_bookings .explanation.top').html('Want to show last '+timePeriod+'\'s bookings until your next deal?');
    $j('.no_bookings .show_last_mo').html('Show Last '+timePeriod);
}

function styleSlideshowLastMonth() {
    $j('.bookings_component .chart .item .bar').css('background', '#aaa');
}

// inverse function from above
function styleSlideshowThisMonth() {
    $j('.bookings_component .chart .item .bar').css('background', '#00B3E9');
    
}

var numTopEmployees = null;

function bookingsByEmpPollResponse(result, timePeriod, showLastPeriod, hasBookingsThisMonth, totalBookingsThisPeriod) {
    if (timePeriod == 'MONTHLY') {
        var timePeriodStr = 'month';
    } else {
        var timePeriodStr = 'quarter';
    }
    if (result.length > 0) {

        removeNoBookingsMessage();
        addEmployees(result);
        numTopEmployees = result.length;
        setupSlideshow(numTopEmployees);

        if (!hasBookingsThisMonth) {
            changeHeader('last', timePeriodStr);
            changeMessage('last', timePeriodStr);
            styleSlideshowLastMonth();
        } else {
            // in case bookings happen in between refreshes,
            // we'll need to undo the changes we make in the functions above
            changeHeader('this', timePeriodStr);
            changeMessage('this', timePeriodStr);
            styleSlideshowThisMonth();
        }
        $j('.bookings_component .total_text').html("Total " + timePeriodStr[0] + "TD");
        $j('.bookings_component .total').html(totalBookingsThisPeriod);
    } else {
        if (showLastPeriod) { 
            if (typeof($j.cookie("ignoreNoBookingsMessage")) === "undefined") {
                changeHeader('this', timePeriodStr);
                changeMessage('this', timePeriodStr); 
            } else {
                changeHeader('last', timePeriodStr);
                changeMessage('last', timePeriodStr); 
            }
        } else {
            changeHeader('this', timePeriodStr);
            changeMessage('this', timePeriodStr); 
        }
    }
}

// to prevent the image from overflowing in the avatar container
function scaleAvatarContainer() {
    $avatar_container = $j('.bookings_component .details .detail .header .avatar_container');
    $avatar_container.each(function() {
        $this = $j(this);
        $this.width($j($this.children()[0]).width());
    });
}

function scaleChart() {
    // size chart labels evenly

    var $chartLabels = $j('.bookings_component .body .chart .item .label');
    var maxLabelWidth = 0;
    $chartLabels.each(function() {
        maxLabelWidth = Math.max($j(this).width(), maxLabelWidth);
    });

    var newLabelWidth = maxLabelWidth + 20;
    $chartLabels.width(newLabelWidth);

    var rowWidth = $j('.bookings_component .body .chart .item').width();
    var newBarContainerWidth = rowWidth - newLabelWidth - 30;
    $j('.bookings_component .body .chart .item .bar_container').width(newBarContainerWidth);

    // move bookings value outside of bar on overflow

    var $chartBars = $j('.bookings_component .body .chart .item .bar_container .bar');
    $chartBars.each(function() {
        var $this = $j(this);
        var $value = $this.children('.value')
        if ($value.outerWidth() > $this.width()) {
            $value.addClass('overflow');
            $value.css('margin-left', ($this.width()+8)+'px');
        }
    });
}

function handleResize() {
    scaleAvatarContainer();
    scaleChart();
}

function startBookingsChartSlideshow() {
    setupSlideshow(numTopEmployees);
    $j(window).resize(handleResize);
}

$j(document).ready(function() {
    if (typeof($j.cookie("ignoreNoBookingsMessage")) === "undefined") {
        $j('.bookings_component .body .no_bookings_container .no_bookings_config_container').show();
    }
    $j('.bookings_component .body .no_bookings_container .ignore_btn').click(function(e) {
        $j('.no_bookings_config_container').fadeOut(200);
        $j.cookie("ignoreNoBookingsMessage", true);
        e.preventDefault();
        return false;
    });
    $j('.bookings_component .body .no_bookings_container .warning_btn').click(function() {
        $j.cookie("ignoreNoBookingsMessage", true);
    });
});
