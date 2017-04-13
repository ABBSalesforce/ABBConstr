var tickerCreated = false;

function createTicker() {
    $j('.ticker .view .items').webTicker({
        speed: 80, //pixels per second
        direction: "left", //if to move left or right
        moving: true, //whether to start the ticker in a moving or static position
        startEmpty: true, //weather to start with an empty or pre-filled ticker
        duplicate: false, //if there is less items then visible on the ticker you can duplicate the items to make it continuous
        rssurl: false, //only set if you want to get data from rss
        rssfrequency: 0, //the frequency of updates in minutes. 0 means do not refresh
        updatetype: "swap", //how the update would occur options are "reset" or "swap"
        hoverpause: false //pause the ticker when hovered
    });
}

function createItem(tickerItem) {
    var labelClass = 'recent_deal';
    if (tickerItem.label == 'New Deal') {
        labelClass = 'new_deal';
    }

    var html = '';
    html += '<li id="'+tickerItem.id+'" class="item">';
    html += '<span class="label '+labelClass+'">'+tickerItem.label+'</span>';
    html += '<span class="double_dash">//</span>';
    html += '<span class="message">'+tickerItem.message+'</span>';
    html += '</li>';
    return html;
}

function addItems(tickerItems) {
    var items = "";
    for (var i=0; i < tickerItems.length; i++) {
        items += createItem(tickerItems[i]);
    }
    var updateMethod = "reset";
    if ($j('.ticker .view .items .item').length > 0) {
        updateMethod = "swap";
    }
    $j('.ticker .view .items').webTicker('update', items, updateMethod);
}

function addDummyItem() {
    var timestamp = new Date().getTime();
    var items = new Array();
    items[0] = {'id': 'deal'+timestamp, 'label': 'New Deal', 'message': 'Raaawr'};
    addItems(items);
}

function tickerPollResponse(result) {
    if (result.length > 0) {
        if (!tickerCreated) {
            createTicker();
            tickerCreated = true;
        }
        addItems(result);
    }
}
