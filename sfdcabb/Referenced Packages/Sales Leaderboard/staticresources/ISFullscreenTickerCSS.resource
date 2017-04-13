.ticker_component .ticker {
  bottom: 0;
  height: 100px;
  overflow: hidden;
  position: absolute;
  width: 100%; }

.ticker_component .ticker .view {
  background: rgba(0,0,0,.8);
  border-bottom: 6px solid rgba(0,0,0,.9);
  border-top: 6px solid rgba(0,0,0,.9);
  display: inline-block;
  height: 100%;
  margin-top: 0px;
  overflow: hidden;
  position: relative;
  white-space: nowrap;
  width: 100%; }

.ticker_component .ticker .view .items {
  color: white;
  height: 100%;
  padding: 19px 0;
  white-space: nowrap;
  width: 100%; }

.ticker_component .ticker .view .items .item {
  color: #FFF;
  display: inline-block;
  font-size: 40px;
  font-weight: normal;
  margin-right: 120px; }

.ticker_component .ticker .view .items .item .label {
  color: #888; }

.ticker_component .ticker .view .items .item .label.new_deal {
  color: #5fba50; }

.ticker_component .ticker .view .items .item .double_dash {
  color: #00b3e9;
  font-weight: 300;
  letter-spacing: -5px;
  margin: 0 20px; }

/* Ticker Library CSS */

.ticker_component .tickercontainer {
  height: 100%;
  margin: 0;
  overflow: hidden;
  padding: 0;
  width: 100%; }

.ticker_component .tickercontainer .mask {
  height: 100%;
  overflow: hidden;
  position: relative; }

.ticker_component ul.newsticker {
  list-style-type: none;
  margin: 0;
  padding: 0;
  position: relative; }

.ticker_component ul.newsticker li {
  float: left;
  margin: 0;
  padding-right: 15px; }

/* End Ticker Library CSS */

.ticker_component .parallelogram {
  border-top: 4px solid #222;
  box-shadow: 9px 0px 20px 2px rgba(0,0,0,0.8), -9px 0px 20px 2px rgba(0,0,0,0.8);
  bottom: 0px;
  width: 100px;
  height: 100px;
  transform: skew(30deg);
  -webkit-transform: skew(30deg);
  -moz-transform: skew(30deg);
  background: #444444;
  background: -moz-linear-gradient(top, #444444 0%, #111111 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#333333), color-stop(100%,#111111));
  background: -webkit-linear-gradient(top, #333333 0%,#111111 100%);
  background: -ms-linear-gradient(top, #444444 0%,#111111 100%);
  background: linear-gradient(to bottom, #333333 0%,#111111 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#444444', endColorstr='#111111',GradientType=0 );
  position: absolute; }

.ticker_component .parallelogram.left {
  left: -60px;
  width: 326px; }

.ticker_component .parallelogram.right {
  right: -60px;
  transform: skew(30deg);
  -webkit-transform: skew(30deg);
  -moz-transform: skew(30deg); }


