* {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  *behavior: url(boxsizing.htc); }

html, body {
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif !important; }

h1, h2, h3 {
  display: block !important;
  text-shadow: none !important;
  text-transform: none !important; }

.hidden {
  display: none; }

.isfullscreen {
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif !important; }

span.disabled {
  opacity: .2; }

input.disabled {
  opacity: .5; }

.filter_values_box.disabled {
  opacity: .5; }

input.disabled:hover {
  cursor: default !important;
  opacity: .5 !important; }

input.filter_value_input.disabled:hover {
  cursor: text !important; }

.option_input:not(.disabled):not(:focus) {
  -webkit-transition:  border .2s ease-in-out;
  -moz-transition:  border .2s ease-in-out;
  transition: border .2s ease-in-out; }

.option_input:not(.disabled):not(:focus):hover {
  border: 1px solid #999 !important; }

.preload_container {
  height: 1px;
  left: -1000px;
  position: absolute;
  width: 1px; }

  /*
   * ANIMATIONS
   */


@keyframes fadein {
  from { opacity: 0; }
  to   { opacity: 1; } }
@-webkit-keyframes fadein {
  from { opacity: 0; }
  to   { opacity: 1; } }


/*
 * SPLASH SCREEN
 */


.splash {
  display: none;
  margin: 0 auto;
  margin-top: 25px;
  position: relative;
  width: 1000px; }

.modal_open {
  opacity: .2; }

.splash .splash_btn {
  border-radius: 3px;
  box-shadow: 0px 2px 7px 0px #000;
  color: #fff;
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

.splash .splash_btn:hover {
  opacity: .9; }

.splash .configure_btn {
  background: rgb(0,179,233);
  background: -moz-linear-gradient(top, rgba(0,179,233,1) 0%, rgba(0,153,199,1) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(0,179,233,1)), color-stop(100%,rgba(0,153,199,1)));
  background: -webkit-linear-gradient(top, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  background: -o-linear-gradient(top, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  background: -ms-linear-gradient(top, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  background: linear-gradient(to bottom, rgba(0,179,233,1) 0%,rgba(0,153,199,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00b3e9', endColorstr='#0099c7',GradientType=0 );
  border: 2px solid #006e8f;
  padding: 8px 17px; }

.splash .launch_btn {
  background: rgb(95,185,80);
  background: -moz-linear-gradient(top, rgba(95,185,80,1) 0%, rgba(81,159,69,1) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(95,185,80,1)), color-stop(100%,rgba(81,159,69,1)));
  background: -webkit-linear-gradient(top, rgba(95,185,80,1) 0%,rgba(81,159,69,1) 100%);
  background: -o-linear-gradient(top, rgba(95,185,80,1) 0%,rgba(81,159,69,1) 100%);
  background: -ms-linear-gradient(top, rgba(95,185,80,1) 0%,rgba(81,159,69,1) 100%);
  background: linear-gradient(to bottom, rgba(95,185,80,1) 0%,rgba(81,159,69,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5fb950', endColorstr='#519f45',GradientType=0 );
  border: 2px solid #32612a;
  margin-left: 50px;
  padding: 8px 38px; }

.splash .splash_header {
  margin-bottom: 60px;
  text-align: center; }

.splash .splash_header img {
  height: 565px; }

.splash .splash_header .options_box {
  height: 221px;
  left: 153px;
  position: absolute;
  top: 307px;
  width: 747px; }

.splash .splash_header .options_box .tagline {
  color: #d1d1d1;
  display: block;
  font-size: 30px;
  font-style: italic;
  font-weight: 400;
  margin-top: 50px;
  text-shadow: 0px 1px 1px #1a1a1a; }

.splash .splash_header .options_box .btn_box {
  margin-top: 44px; }

.splash .splash_section {
  background: #f4f4f4;
  margin-left: 146px;
  margin-top: 55px;
  padding: 35px;
  padding-top: 40px;
  position: relative;
  width: 760px; }

.splash .splash_section .section_header {
  display: block;
  left: -18px;
  position: absolute;
  top: -22px; }

.splash .splash_section .splash_section_inner {
  background: #fff;
  border-left: 4px solid #00b3e9;
  padding: 25px; }

.splash .splash_section .splash_section_inner .inner_title {
  color: #333;
  display: block;
  font-size: 17px;
  font-weight: 700;
  margin-bottom: 5px; }

.splash .splash_section .splash_section_inner .inner_title.contact {
  font-weight: 400; }

.splash .splash_section .splash_section_inner .inner_title.contact a {
  padding-left: 3px; }

.splash .splash_section .splash_section_inner .inner_title:not(:first-child) {
  margin-top: 30px; }

.splash .splash_section .splash_section_inner .inner_desc {
  color: #666;
  font-size: 15px; }

.splash .splash_section .splash_section_inner a {
  color: #00b3e9;
  text-decoration: none;
  -webkit-transition: .2s background ease-in-out, .2s color ease-in-out;
  -moz-transition: .2s background ease-in-out, .2s color ease-in-out;
  transition: .2s background ease-in-out, .2s color ease-in-out; }

.splash .splash_section .splash_section_inner a:hover {
  color: #0099c7; }

/*
 * CONFIG SCREEN
 */

.config {
  display: none;
  margin: 0 auto;
  overflow: visible !important;
  width: 800px; }

/*
.ui-autocomplete {
  max-height: 400px;
  overflow-y: auto;
  overflow-x: hidden; }
*/

.ui-menu {
  border: none !important;
  border-radius: 2px !important;
  box-shadow: rgba(0, 0, 0, 0.6) 0px 2px 30px !important;
  padding: 0px; }

.ui-menu .ui-menu-item a {
  background: #FFF;
  border: 2px;
  border-left: 3px solid rgba(0,0,0,.3);
  border-radius:0px;
  color: #555;
  margin: 0px !important;
  margin-left: -1px !important;
  padding: 5px 13px;
  -webkit-transition: .2s background ease-in-out, .2s color ease-in-out;
  -moz-transition: .2s background ease-in-out, .2s color ease-in-out;
  transition: .2s background ease-in-out, .2s color ease-in-out; }

.ui-state-focus {
  background: #00b3e9 !important;
  border: 2px;
  border-left: 3px solid rgba(0,0,0,.3);
  border-radius: 0px;
  color: #FFF !important;
  margin: 0px !important;
  text-shadow: 0px 1px 1px rgba(0,0,0,.3);
  -webkit-transition: .2s background ease-in-out, .2s color ease-in-out;
  -moz-transition: .2s background ease-in-out, .2s color ease-in-out;
  transition: .2s background ease-in-out, .2s color ease-in-out; }

.error {
  color: #e96955;
  display: none;
  font-size: 17px;
  font-weight: 600;
  margin-left: 20px; }

.config .config_header {
  margin-top: 30px;
  text-align: center; }

.config .config_section {
  background: #f4f4f4;
  margin-top: 62px;
  padding-bottom: 25px; }

.config .config_section .section_title {
  margin-bottom: 20px;
  margin-left: -18px;
  margin-top: -22px; }

.config .config_section .section_desc {
  color: #454545;
  display: block;
  font-size: 18px;
  margin: 0px 22px; }

.config .config_section .option {
  background: #fff;
  border-left: 4px solid #00b3e9;
  display: inline-block;
  margin-left: 22px;
  margin-right: 22px;
  margin-top: 20px;
  padding: 10px 0;
  padding-right: 35px; }

.config .config_section .option .input_box {
  padding-top: 10px; }

.config .config_section .option .option_label {
  color: #333;
  display: inline-block;
  font-size: 17px;
  font-weight: 600;
  margin-left: 19px;
  margin-right: 19px;
  margin-top: 8px;
  text-transform: uppercase;
  vertical-align: top; 
  float: left;
}

.config .config_section .option .option_input {
  border: 1px solid #ccc;
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif !important;
  outline: none;
  padding: 8px 13px;
  padding-right: 30px;
  width: 240px; }

.config .config_section .option .option_input.invalid {
  border: 1px solid #e96955 !important;
  box-shadow: 0px 0px 7px #e96955 !important;
  outline: auto 2px #e96955 !important; }

.config .config_section .option .option_input.disabled, .config .config_section .option .option_input[disabled] {
  border: 1px solid #ccc !important; }

.config .config_section .option .option_input:not(.disabled):focus, .config .config_section .option .option_input.focus {
  -webkit-transition: all .2s ease-in-out;
  -moz-transition: all .2s ease-in-out;
  -ms-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out;
  outline: auto 2px #00b3e9;
  border: 1px solid #00b3e9;
  box-shadow: 0px 0px 7px #00b3e9; }

.config .config_section .option.filter_option {
  display: block;
  padding-top: 0; }

.config .config_section .option.filter_option .filter_option_del {
  cursor: pointer;
  float: right;
  margin-right: -28px;
  margin-top: 16px;
  opacity: 0;
  transition: all .4s;
  -webkit-transition: all .4s;
  -moz-transition: all .4s;
  transition: all .4s; }

.config .config_section .option.filter_option:hover .filter_option_del {
  display: block;
  opacity: .8; }

.config .config_section .option.filter_option:hover .filter_option_del:hover {
  display: block;
  opacity: 1; }

.config .config_section .option.filter_option .option_label {
  width: 60px; }

.config .config_section .option.filter_option .option_label.filter_label {
  margin-top: 14px; }

.config .config_section .option.filter_option .filter_values_box {
  cursor: text;
  display: inline-block;
  padding-bottom: 6px;
  padding-top: 13px;
  width: 610px; }

.config .config_section .option.filter_option .filter_values_box .filter_value_box {
  -webkit-animation: fadein .4s ease-in-out;
  animation: fadein .4s ease-in-out;
  background: #DDE6E9;
  border: 1px solid #9AB8CC;
  display: inline-block;
  margin-bottom: 6px;
  margin-right: 5px;
  vertical-align: middle; }

.config .config_section .option.filter_option .filter_values_box .filter_value_box .filter_value {
  color: #333;
  display: inline-block;
  font-size: 14px;
  font-weight: 400;
  padding: 0 6px;
  -moz-transition: all .2s ease-in-out;
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out;
  vertical-align: middle; }

.config .config_section .option.filter_option .filter_values_box .filter_value_box .filter_value_del {
  display: inline-block;
  height: 26px;
  -moz-transition: all .2s ease-in-out;
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out;
  vertical-align: middle;
  width: 25px; }

.config .config_section .option.filter_option .filter_values_box .filter_value_box .filter_value_del:hover {
  cursor: pointer; }

.config .config_section .option.filter_option .filter_values_box .filter_value_box.del_hover {
  border: 1px solid #00b3e9; }

.config .config_section .option.filter_option .filter_values_box .filter_value_box .filter_value.del_hover {
  color: #000; }

.config .config_section .option.filter_option .filter_values_box .filter_value_input {
  background: #fff;
  border: none;
  display: inline-block;
  margin-bottom: 7px;
  outline: none;
  padding: 5px 0px;
  padding-left: 4px;
  vertical-align: middle;
  width: 140px; }

.config .config_section .option.filter_option .filter_values_box .filter_value_input:hover {
  cursor: text; }

.config .filter_option_divider {
  background: #f9f9f9;
  border: 1px solid #ddd;
  color: #aaa;
  display: block;
  font-size: 14px;
  font-weight: 600;
  margin: 10px auto -10px auto;
  margin-bottom: -3px;
  margin-top: 17px;
  padding: 4px 0;
  text-align: center;
  text-transform: uppercase;
  width: 50px; }

.config .config_section.filter_section .add_filter_btn {
  background: linear-gradient(to bottom, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  border-bottom: 2px solid #737373;
  border-radius: 2px;
  color: #fff;
  display: inline-block;
  font-size: 14px;
  font-weight: 600;
  margin-left: 19px;
  margin-top: 25px;
  padding: 6px 10px;
  text-align: center;
  text-shadow: 0px 1px #777;
  text-transform: uppercase;
  -moz-transition: all .2s ease-in-out;
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out; }

.config .config_section.filter_section .add_filter_btn:hover {
  cursor: pointer;
  opacity: .9; }

.config .launch_box {
  margin-bottom: 60px;
  margin-top: 40px;
  text-align: center; }

.config .launch_box .action_btn {
  border-left: none;
  border-right: none;
  border-top: none;
  border-radius: 2px;
  color: #fff;
  cursor: pointer;
  font-family: 'Source Sans Pro', 'SourceSansPro', sans-serif !important;
  font-size: 13px;
  font-weight: 700;
  text-decoration: none;
  text-transform: uppercase;
  -moz-transition: all .2s ease-in-out;
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out; }

.config .launch_box .action_btn:hover {
  opacity: .9; }

.config .launch_box .launch_btn {
  background: rgb(118,196,105);
  background: -moz-linear-gradient(top, rgba(118,196,105,1) 0%, rgba(82,160,69,1) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(118,196,105,1)), color-stop(100%,rgba(82,160,69,1)));
  background: -webkit-linear-gradient(top, rgba(118,196,105,1) 0%,rgba(82,160,69,1) 100%);
  background: -o-linear-gradient(top, rgba(118,196,105,1) 0%,rgba(82,160,69,1) 100%);
  background: -ms-linear-gradient(top, rgba(118,196,105,1) 0%,rgba(82,160,69,1) 100%);
  background: linear-gradient(to bottom, rgba(118,196,105,1) 0%,rgba(82,160,69,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#76c469', endColorstr='#52a045',GradientType=0 );
  border-bottom: 2px solid #1e7a0d;
  margin-left: 20px;
  padding: 12px 50px;
  text-shadow: 0px 1px #888; }

.config .launch_box .cancel_btn {
  background: rgb(203,203,203);
  background: -moz-linear-gradient(top, rgba(203,203,203,1) 0%, rgba(188,188,188,1) 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(203,203,203,1)), color-stop(100%,rgba(188,188,188,1)));
  background: -webkit-linear-gradient(top, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  background: -o-linear-gradient(top, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  background: -ms-linear-gradient(top, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  background: linear-gradient(to bottom, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cbcbcb', endColorstr='#bcbcbc',GradientType=0 );
  border-bottom: 2px solid #898989;
  padding: 12px 40px;
  text-shadow: 0px 1px #aaa; }

.config .time_section .radio_wrapper {
    float: right;
    border-radius: 2px;
    padding: 3px;
}
  
 .config .time_section input[type="radio"] {
   display: none;
 }
 
 .config .time_section label {
   font-weight: 700;
   display: inline-block;
   font-size: 20x;
   padding: 6px 24px;
   padding-top: 8px;
   margin: 0px 6px;
   background: linear-gradient(to bottom, rgba(203,203,203,1) 0%,rgba(188,188,188,1) 100%);
   color: white;
   border-radius: 2px;
   border-bottom: 2px solid white;
   -moz-transition: all .2s ease-in-out;
   -webkit-transition: all .2s ease-in-out;
   transition: all .2s ease-in-out; }

 .config .time_section label:hover {
  cursor: pointer;
  opacity: .9; }
 
 .config .time_section input[type="radio"]:checked + label {
   background: #00b3E9;
   border-bottom: 2px solid #0095C2;
   text-shadow: 0px 1px #aaa;
 }

/*
 * MODAL
 */

.warning_modal {
  display: none; }

.warning_container {
  position: fixed;
  top: 0px;
  width: 1000px; }

.warning_container .warning_box {
  background: rgba(0,0,0,.9);
  border: 3px solid #00b3e9;
  border-radius: 2px;
  box-shadow: 0px 0px 30px 1px;
  min-height: 400px;
  margin: 0 auto;
  margin-top: 230px;
  padding: 30px 40px;
  width: 760px; }

.warning_container .warning_box .warning_close_btn {
  cursor: pointer;
  float: right;
  margin-right: -25px;
  margin-top: -15px; }

.warning_container .warning_box .warning_title {
  color: #fff;
  display: block;
  font-size: 42px;
  font-weight: 900; }

.warning_container .warning_box .warning_msg {
  color: #fff;
  display: block;
  font-size: 23px;
  margin-top: 30px; }

.warning_container .warning_box .warning_btn_box {
  margin-top: 60px;
  text-align: center; }

.warning_modal .warning_container .warning_box .warning_btn_box .warning_btn {
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
  color: #fff;
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

.warning_modal.unknown_error .warning_container .warning_box a {
  color: #00b3e9;
  text-decoration: none; }