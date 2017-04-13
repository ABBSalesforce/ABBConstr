var INTRO_SHOW_TIME = 4100;
var DETAIL_SHOW_TIME = 3900;
var VISIBLE_TIME = 1000*60*1;
var SLIDESHOW_POLL_TIME = 10000;

function createNewDeal(deal) {
    return ' \
      <div id="'+deal.opportunity.Id+'" class="new_deal"> \
        <div class="new_deal_inner"> \
          <div class="header"> \
            <span class="parallelogram dark_gradient"></span> \
            <span class="vertical_aligner"></span> \
            <span class="title">'+deal.opportunity.Name+'</span> \
          </div> \
          <div class="contents"> \
            <div class="stats"> \
              <div class="stat amount"> \
                <span class="value">'+deal.fAmount+'</span> \
                <span class="unit">amount</span> \
              </div> \
              <div class="stat sales_cycle"> \
                <span class="value">'+deal.salesCycle+'</span> \
                <span class="days">days</span> \
                <span class="unit">sales cycle</span> \
              </div> \
            </div> \
            <div class="owner"> \
              <div class="avatar_container"> \
                <div class="avatar_wrapper"> \
                  <span class="vertical_aligner"></span> \
                  <img class="avatar" src="'+deal.opportunity.Owner.FullPhotoUrl+'" /> \
                </div> \
              </div> \
              <div class="label"> \
                <span class="parallelogram dark_gradient"></span> \
                <span class="square dark_gradient"></span> \
                <div class="text_container"> \
                  <span class="vertical_aligner"></span> \
                  <span class="name">'+deal.opportunity.Owner.Name+'</span> \
                </div> \
              </div> \
            </div> \
          </div> \
        </div> \
      </div>';
}

function newDealPollResponse(result) {
    var $newDeals = $j('.newdeal_component .new_deals');
    for (var i = 0; i < result.length; i++) {
        var deal = result[i];
        if ($j('#'+deal.opportunity.Id).length === 0) {
            $newDeals.append(createNewDeal(deal));
        }
    }
}

// NEW DEAL SLIDESHOW

var needToShowIntro = true;

function prepSlideshow() {
    $j('.newdeal_component .new_deals .new_deal').hide();
    $j('.new_deals').show();
}

function showNewDealsIntro() {
    $j('.swoosh_player').trigger('play');
    setTimeout(function() {
        setTimeout(function() {
            $j('.sub_bass_player').trigger('play');
        }, 650);
        setTimeout(function() {
            $j('.swoosh_out_player').trigger('play');
        }, 3800);
        prepSlideshow();
        hideScreen();
        $new_deals_intro = $j('.newdeal_component .new_deals .intro');
        $new_deals_intro.show();
        setTimeout(function() {
            slideShow();
        }, DETAIL_SHOW_TIME);
        setTimeout(function() {
            $new_deals_intro.fadeOut();
        }, INTRO_SHOW_TIME);
    }, 1550);
}

function slideShow() {
    if ($j('.newdeal_component .new_deals .new_deal').length === 0) {
        setBackgroundVideo(BG_VIDEO_MP4, BG_VIDEO_OGV);
        needToShowIntro = true;
        showScreen(function() {
            $j('.new_deals').hide();
            setTimeout(function() {
                slideShow();
            }, SLIDESHOW_POLL_TIME);
        });
    }
    else {
        if (needToShowIntro) {
            needToShowIntro = false;
            showNewDealsIntro();
        }
        else {
            setBackgroundVideo(NEW_DEAL_MP4, NEW_DEAL_OGV);
            prepSlideshow();
            $new_deals_intro = $j('.newdeal_component .new_deals .intro');
            $new_deals_intro.next().fadeIn(1000);

            setTimeout(function() {
                $new_deals_intro.next().fadeOut(800, function() {
                    $new_deals_intro.next().remove();
                    slideShow();
                });
            }, VISIBLE_TIME);
        }
    }
}

function startNewDealWatcher() {
    slideShow();
}
