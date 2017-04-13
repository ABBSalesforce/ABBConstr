.bookings_component {
  height: 100%;
  width: 100%; }

.bookings_component .title_wrapper {
  height: 21%;
  margin-left: 30px;
  margin-right: 30px;
  margin-top: 25px;
  overflow: hidden; }

.bookings_component .title {
  color: #FFF;
  display: inline-block;
  padding: 20px; }

.bookings_component .total_wrapper {
  float: right;
  display: inline-block; }

.bookings_component .total {
  color: #FFF;
  display: inline-block;
  font-size: 48px;
  font-weight: 600;
  text-align: right;
  margin-left: 20px;
  margin-top: 24px; }

.bookings_component .subtitle {
  color: #00b3e9;
  display: inline-block;
  font-size: 2.7em;
  font-style: italic;
  font-weight: 300;
  margin-left: 20px;
  margin-top: -26px;
  text-transform: uppercase;
  vertical-align: middle; }

.bookings_component .total_text {
  color: #5fba50;
}

@media screen and (max-width: 1325px) {
    .bookings_component .total, .bookings_component .total_text {
        display: none !important;
    }
}

.bookings_component .body {
  height: 72%;
  width: 100%; }

.bookings_component .body .no_bookings_container {
  margin-top: 5%;
  text-align: center; }

.bookings_component .body .no_bookings_container .no_bookings {
  background: rgba(0,0,0,.2);
  color: #666;
  display: inline-block;
  font-size: 2.7em;
  font-weight: 300;
  padding: 15px 25px;
  text-transform: uppercase; }

.bookings_component .body .no_bookings_container .no_bookings_config_container {
  display: none; }

.bookings_component .body .no_bookings_container .explanation {
  display: block;
  font-size: 30px;
  margin-bottom: 5px;
  margin-top: 15px;
  text-transform: none; }


.bookings_component .body .no_bookings_container .explanation.config {
  margin-top: 36px;
  font-size: 25px; }

.bookings_component .body .no_bookings_container .warning_btn {
  box-shadow: none;
  font-size: 17px;
  margin-bottom: 15px;
  margin-top: 25px; }

.bookings_component .body .no_bookings_container .ignore_btn {
  background: rgb(203,203,203);
  background: -moz-linear-gradient(top, rgba(203,203,203,1) 0%, rgba(188,188,188,1) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(203,203,203,1)), color-stop(100%,rgba(188,188,188,1)));
  background: -webkit-linear-gradient(top, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  background: -o-linear-gradient(top, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  background: -ms-linear-gradient(top, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  background: linear-gradient(to bottom, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cbcbcb', endColorstr='#bcbcbc',GradientType=0 );
  border: 2px solid #898989;
  padding: 8px 17px;
  text-shadow: 0px 1px #aaa;
  border-radius: 2px;
  color: #fff;
  cursor: pointer;
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif !important;
  font-size: 17px;
  font-weight: 700;
  text-decoration: none;
  text-transform: uppercase;
  -moz-transition: all .2s ease-in-out;
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out;
  display: inline-block;
  width: 130px;
  font-style: italic;
  margin-right: 10px; }

.bookings_component .body .no_bookings_container .ignore_btn:hover {
  opacity: .9; }

.bookings_component .chart {
  float: left;
  margin: 0;
  padding: 0;
  width: 63%; }

.bookings_component .chart .item {
  list-style-type: none;
  margin: 15px 0;
  margin-left: 50px;
  padding: 12px 0;
  padding-left: 15px;
  position: relative; }

.bookings_component .chart .item .highlight {
  background: -moz-linear-gradient(left,  rgba(100,100,100,0.5) 00%, rgba(125,185,232,0.05) 76%, rgba(0,197,233,0.7) 100%); /* FF3.6+ */
  background: -webkit-gradient(linear, left top, right top, color-stop(00%,rgba(100,100,100,0.5)), color-stop(76%,rgba(125,185,232,0.05)), color-stop(100%,rgba(0,197,233,0.7))); /* Chrome,Safari4+ */
  background: -webkit-linear-gradient(left,  rgba(100,100,100,0.5) 00%,rgba(125,185,232,0.05) 76%,rgba(0,197,233,0.7) 100%); /* Chrome10+,Safari5.1+ */
  background: -o-linear-gradient(left,  rgba(100,100,100,0.5) 00%,rgba(125,185,232,0.05) 76%,rgba(0,197,233,0.7) 100%); /* Opera 11.10+ */
  background: -ms-linear-gradient(left,  rgba(100,100,100,0.5) 00%,rgba(125,185,232,0.05) 76%,rgba(0,197,233,0.7) 100%); /* IE10+ */
  background: linear-gradient(to right,  rgba(100,100,100,0.5) 00%,rgba(125,185,232,0.05) 76%,rgba(0,197,233,0.7) 100%); /* W3C */
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#80646464', endColorstr='#b300c5e9',GradientType=1 ); /* IE6-9 */
  bottom: 0;
  left: 0;
  position: absolute;
  right: 0;
  top: 0;
  z-index: -1; }

.bookings_component .chart .item .label {
  display: inline-block;
  margin: 0;
  max-width: 340px;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
  white-space: nowrap; }

.bookings_component .body .chart .item .bar_container {
  display: inline-block; }

.bookings_component .chart .item .bar {
  background: #00B3E9;
  border-top: 2px solid rgba(255,255,255,0.6);
  box-shadow: 1px 2px 5px 1px rgba(0,0,0,0.5);
  display: inline-block;
  line-height: 54px;
  min-width: 7px;
  vertical-align: middle; }

.bookings_component .chart .item .bar .value {
  color: #000;
  float: right;
  font-size: 41px;
  font-weight: 600;
  margin-right: 10px;
  padding: 0 10px;
  text-shadow: none; }

.bookings_component .chart .item .bar .value.overflow {
  color: #fff;
  float: none; }

.bookings_component .details {
  float: left;
  height: 100%;
  position: relative;
  width: 37%; }

.bookings_component .detail {
  background: rgba(0,0,0,0.6);
  border: 2px solid #00b3e9;
  height: 100%;
  position: absolute;
  width: 95%; }

.bookings_component .details .detail .header {
  height: 60%;
  position: relative;
  text-align: center; }

.bookings_component .details .detail .header .avatar_container {
  background: rgba(200,200,200, 0.2);
  border-radius: 3px;
  display: inline-block;
  height: 75%;
  margin-top: 4%;
  padding: 5px; }

.bookings_component .details .detail .header .avatar {
  height: 100%; }

.bookings_component .details .detail .header .name_container {
  bottom: 0;
  overflow: hidden;
  position: absolute;
  width: 100%; }

.bookings_component .details .detail .header .name {
  display: inline-block;
  font-size: 40px;
  font-weight: 900;
  line-height: 110%;
  max-width: 100%;
  min-width: 55%;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
  white-space: nowrap; }

.bookings_component .details .detail .content {
  height: 40%;
  padding: 2% 0% 5% 0%; }

.bookings_component .details .detail .content .item {
  height: 33%;
  list-style-type: none; }

.bookings_component .details .detail .content .item.stat {
  position: relative;
  text-align: center; }

.bookings_component .details .detail .content .item .number {
  color: #fff;
  display: inline-block;
  font-size: 40px;
  font-weight: 600;
  margin-top: -1%;
  padding-right: 6%;
  text-align: right;
  vertical-align: middle;
  width: 45%; }

.bookings_component .details .detail .content .item .unit {
  color: #5fBA50;
  display: inline-block;
  font-size: 35px;
  max-width: 300px;
  text-align: left;
  text-transform: uppercase;
  vertical-align: middle;
  width: 50%; }

/* Animations */

@keyframes moveup {
    from { transform: translate(0, 20px); }
    to   { transform: translate(0, 0); } }
@-webkit-keyframes moveup {
    from { -webkit-transform: translate(0, 20px); }
    to   { -webkit-transform: translate(0, 0); } }

@keyframes movedown {
    from { transform: translate(0, -30px); }
    to   { transform: translate(0, 0); } }
@-webkit-keyframes movedown {
    from { -webkit-transform: translate(0, -30px); }
    to   { -webkit-transform: translate(0, 0); } }

@keyframes fadein_fast {
    0%  { opacity: 0; }
    10% { opacity: 1; }
    100% { opacity: 1; } }
@-webkit-keyframes fadein_fast {
    0%  { opacity: 0; }
    10% { opacity: 1; }
    100% { opacity: 1; } }

@keyframes fadeout_fast {
    0%  { opacity: 1; }
    10% { opacity: 0; } }
@-webkit-keyframes fadeout_fast {
    0%  { opacity: 1; }
    10% { opacity: 0; } }

.bookings_component .title {
  animation: fadein .5s linear .5s, moveup .5s linear .5s;
  -webkit-animation: fadein .5s linear .5s, moveup .5s linear .5s;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  opacity: 0; }

.bookings_component .subtitle, .bookings_component .total {
  animation: fadein .5s ease-in-out 1s;
  -webkit-animation: fadein .5s ease-in-out 1s;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  opacity: 0; }

.bookings_component .chart .item {
  animation: fadein .5s, movedown .5s;
  -webkit-animation: fadein .5s, movedown .5s;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  opacity: 0; }

.bookings_component .chart .item.row1 {
  animation-delay: .6s;
  -webkit-animation-delay: .6s; }
.bookings_component .chart .item.row2 {
  animation-delay: .8s;
  -webkit-animation-delay: .8s; }
.bookings_component .chart .item.row3 {
  animation-delay: 1s;
  -webkit-animation-delay: 1s; }
.bookings_component .chart .item.row4 {
  animation-delay: 1.2s;
  -webkit-animation-delay: 1.2s; }
.bookings_component .chart .item.row5 {
  animation-delay: 1.4s;
  -webkit-animation-delay: 1.4s; }

.bookings_component .chart .item .highlight {
  opacity: 0;
  transition: opacity .5s ease-in .5s;
  -webkit-transition: opacity .5s ease-in .5s; }

.bookings_component .chart .item .highlight.show {
  opacity: 1; }

.bookings_component .detail {
  transition: opacity .5s ease-in-out .5s, transform .5s ease-in-out .5s;
  -webkit-transition: opacity .5s ease-in-out .5s, -webkit-transform .5s ease-in-out .5s;
  transform: translateX(-26px);
  -webkit-transform: translateX(-26px);
  opacity: 0; }

.bookings_component .detail.show {
  opacity: 1;
  transform: translateX(0);
  -webkit-transform: translateX(0); }
