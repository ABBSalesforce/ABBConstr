* {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  *behavior: url(boxsizing.htc);
  outline: none; }


/*
 * ANIMATIONS
 */


@keyframes fadein {
  from { opacity: 0; }
  to   { opacity: 1; } }
@-webkit-keyframes fadein {
  from { opacity: 0; }
  to   { opacity: 1; } }

@keyframes fadeout {
  from { opacity: 1; }
  to   { opacity: 0; } }
@-webkit-keyframes fadeout {
  from { opacity: 1; }
  to   { opacity: 0; } }


/*
 * GENERIC
 */


html, body {
  background: #444;
  color: #fff;
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif;
  margin: 0;
  overflow: hidden;
  padding: 0;
}

h1, h2, h3 {
  margin: 0;
  padding: 0;
  text-shadow: 0px 1px 3px #000;
  text-transform: uppercase;
}

h1 {
  font-size: 52px;
  font-weight: 900; }

h2 {
  font-size: 36px;
  font-weight: 400; }

ul {
  margin: 0;
  padding: 0; }

.vertical_aligner {
  display: inline-block;
  height: 100%;
  vertical-align: middle; }

.isfullscreen.hide_mouse {
  cursor: none; }

/*
 * LOADING SCREEN
 */


.spinner {
  height: 100%;
  position: absolute;
  width: 100%; }

.spinner .background {
  height: 100%;
  text-align: center;
  width: 100%; }

.spinner .background .title {
  display: inline-block;
  margin: 0 auto;
  vertical-align: middle; }

.spinner .background, .spinner .background .title {
  -webkit-transition: fadein .8s ease-in-out;
  transition: fadein .8s ease-in-out; }

.spinner .background .loading_container {
  bottom: 5%;
  left: 0;
  position: absolute;
  text-align: center;
  width: 100%; }

.spinner .background .loading_container .indicator {
  display: inline-block;
  height: 25px;
  opacity: .3;
  margin-right: 15px;
  vertical-align: middle; }

.spinner .background .loading_container .loading {
  color: #666;
  display: inline-block;
  font-size: 1.4em;
  font-weight: 600;
  height: 100%;
  text-transform: uppercase;
  vertical-align: middle; }


/*
 * PAGE
 */


.page {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0; }

.logo .is2 {
  bottom: 26px;
  left: 10px;
  height: 40px;
  opacity: 1;
  position: absolute;
  width: 330px; }

.logo .parallelogram {
  border-top: 4px solid #222;
  box-shadow: 10px 20px 30px 10px rgba(0,0,0,0.9);
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
  left: -60px;
  position: absolute;
  width: 326px; }

.slide-container {
  bottom: 100px;
  left: 0;
  position: absolute;
  right: 0;
  text-align: center;
  top: 0;
  width: 100%; }

.slide {
  transition: fadein 500ms ease-in-out;
  -webkit-transition: fadein 500ms ease-in-out;
  border: 4px solid rgba(0,179,233,.88);
  border-radius: 0px;
  box-shadow: 0px 4px 40px rgba(0,0,0,.8), inset 0px 0px 280px 0px #000;
  display: inline-block;
  height: 90%;
  max-height: 800px;
  max-width: 1700px;
  min-height: 670px;
  min-width: 1240px;
  text-align: left;
  text-shadow: 0px 1px 3px rgba(0,0,0,0.4);
  vertical-align: middle;
  width: 94%; }


/*
 * MODAL
 */


.warning_modal {
  background: rgba(0,0,0,0.8);
  display: none;
  height: 100%;
  position: fixed;
  width: 100%; }

.warning_modal .warning_container { }

.warning_modal .warning_container .warning_box {
  background: rgba(0,0,0,.9);
  border: 3px solid #00b3e9;
  border-radius: 2px;
  box-shadow: 0px 0px 30px 1px;
  min-height: 400px;
  margin: 0 auto;
  margin-top: 190px;
  padding: 30px 40px;
  width: 760px; }

.warning_modal .warning_container .warning_box .warning_close_btn {
  cursor: pointer;
  float: right;
  margin-right: -25px;
  margin-top: -15px; }

.warning_modal .warning_container .warning_box .warning_title {
  color: #fff;
  display: block;
  font-size: 42px;
  font-weight: 900; }

.warning_modal .warning_container .warning_box .warning_msg {
  color: #fff;
  display: block;
  font-size: 23px;
  margin-top: 30px; }

.warning_modal .warning_container .warning_box .warning_btn_box {
  margin-top: 75px;
  text-align: center; }

.warning_btn {
  background: rgb(0,179,233);
  background: -moz-linear-gradient(top, rgba(0,179,233,1) 0%, rgba(0,153,199,1) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(0,179,233,1)), color-stop(100%,rgba(0,153,199,1)));
  background: -webkit-linear-gradient(top, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  background: -o-linear-gradient(top, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  background: -ms-linear-gradient(top, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  background: linear-gradient(to bottom, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00b3e9', endColorstr='#0099c7',GradientType=0 );
  border: 2px solid #006e8f;
  padding: 8px 17px;
  border-radius: 3px;
  box-shadow: 0px 2px 7px 0px #000;
  color: #fff !important;
  display: inline-block;
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif !important;
  font-size: 27px;
  font-weight: 700;
  font-style: italic;
  text-decoration: none;
  text-shadow: 0px 1px 1px #666;
  text-transform: uppercase;
  -webkit-transition:  all .2s ease-in-out;
  -moz-transition:  all .2s ease-in-out;
  transition: all .2s ease-in-out; }

.warning_btn:hover {
  opacity: .9; }

.warning_container .warning_box iframe {
  display: block;
  margin: 0 auto;
  margin-top: 25px;
  width: 420px; }

.warning_container .warning_box a {
  color: #00b3e9;
  text-decoration: none; }

.unknown_error .warning_container .warning_box {
  margin-top: 130px; }


/*
 * CONTROLS
 */

.controls_container {
  height: 80px;
  left: 0;
  position: fixed;
  top: 0;
  width: 100%; }

.controls_container .controls {
  background: -moz-linear-gradient(top,  rgba(0,0,0,1) 0%, rgba(0,0,0,0.79) 10%, rgba(0,0,0,0.4) 28%, rgba(0,0,0,0.4) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(0,0,0,1)), color-stop(10%,rgba(0,0,0,0.79)), color-stop(28%,rgba(0,0,0,0.4)), color-stop(100%,rgba(0,0,0,0.4)));
  background: -webkit-linear-gradient(top,  rgba(0,0,0,1) 0%,rgba(0,0,0,0.79) 10%,rgba(0,0,0,0.4) 28%,rgba(0,0,0,0.4) 100%);
  background: -o-linear-gradient(top,  rgba(0,0,0,1) 0%,rgba(0,0,0,0.79) 10%,rgba(0,0,0,0.4) 28%,rgba(0,0,0,0.4) 100%);
  background: -ms-linear-gradient(top,  rgba(0,0,0,1) 0%,rgba(0,0,0,0.79) 10%,rgba(0,0,0,0.4) 28%,rgba(0,0,0,0.4) 100%);
  background: linear-gradient(to bottom,  rgba(0,0,0,1) 0%,rgba(0,0,0,0.79) 10%,rgba(0,0,0,0.4) 28%,rgba(0,0,0,0.4) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#000000', endColorstr='#66000000',GradientType=0 );
  height: 80px;
  -webkit-transform: translateY(-80px);
  transform: translateY(-80px);
  -moz-transition:  all .2s ease-in-out;
  -webkit-transition:  all .2s ease-in-out;
  transition: all .2s ease-in-out;
  width: 100%; }

.controls_container .controls.visible {
  -webkit-transform: translateY(0px);
  transform: translateY(0px); }

.controls_container .controls .control_btn {
  border: 3px solid #fff;
  color: #fff;
  font-size: 28px;
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif;
  font-weight: 900;
  margin-top: 14px;
  margin-left: 16px;
  margin-right: 16px;
  padding: 5px 40px 6px 10px;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
  text-align: center;
  -moz-transition: all .2s ease-in-out;
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out;
  font-style: italic;
  text-transform: uppercase; }

.controls_container .controls .control_btn:hover {
  border: 3px solid #00b3e9;
  box-shadow: 0px 0px 5px #00b3e9;
  text-shadow: -1px -1px 1px #00b3e9; }

.controls_container .controls .control_btn.configure {
   }

.controls_container .controls .control_btn.close {
  float: right; }

