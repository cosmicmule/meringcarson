﻿package com.banner.bannersizes {		import flash.display.*;	import flash.display.Graphics;	import flash.events.*;				// custom classes	import com.banner.util.ClickArea;	import com.banner.Banner;	import com.banner.game;	import com.banner.util.appMode;				public class Leaderboard extends Banner {		 // instantiate & set banner into idle mode		 private var app_Mode:Boolean = true;		 private var app_Mode_timer:appMode;		 private var bannerState:*;		 private var bannerCount:Number = 0;		 private var bannerSquences:Array = [];		 private var GC:Array = [];				// Initialization:		public function Leaderboard() {			super();			init();						stage.addEventListener(MouseEvent.MOUSE_OVER, checkBoundaries_over);		}				// Public Methods:		public override function init():void {			super.init();			bannerSetUp();		}				private function checkBoundaries_over(e:Event){						stage.removeEventListener(MouseEvent.MOUSE_OVER, checkBoundaries_over);						try{removeChild(getChildAt(1));}catch(e:Error){trace("error")}			bannerState = null;						app_Mode = false;			GC = [];						bannerCount = 0			bannerSetUp();					}				public function bannerSetUp(){			// add banners to stage			bannerState = new creative();			addChild(bannerState);						// control children of the creative movieclip			var child = bannerState.getChildAt(0);			bannerState.getChildAt(0).stop();			bannerState.getChildAt(1).stop();			bannerState.getChildAt(2).stop();								// Banner sequence order			// if user does not rollovers over flash object			if(app_Mode == true){				bannerSquences = [];				bannerSquences.push([0, 0]); // frm 1 - way to think fast				bannerSquences.push([1, 1]); // frm 2 - #thinkfast  				bannerSquences.push([2, 0]); // frm 3 - ticket section						// if user rollovers over flash object			}else{				bannerSquences = [];				bannerSquences.push([0, 0]); // frm 1 - way to think fast				bannerSquences.push(["game", 1]); // game Object				bannerSquences.push([1, 1]); // frm 2 - #thinkfast 				bannerSquences.push([2, 0]); // frm 3 - ticket section			}						runBanners();		}				public function continueBanner() {						removeChild(bannerState);			bannerState = null;						bannerState = new creative();			addChild(bannerState);						bannerCount++;			runBanners();		}				private function runBanners(){			trace(app_Mode);			try{				app_Mode_timer.AppMode = false;				app_Mode_timer = null;								}catch(e:Error){"Error no timer evert exists"}						// cleanup GC collection			if(GC.length != 0){				GC_cleanup();			}						// set what background to use			if(bannerSquences[bannerCount][1] == 1){				super.set_background();			}else{				super.reset_background();			}									// instantiate game if possible			if(bannerSquences[bannerCount][0] == "game"){								// banner animation class removed fomr stage				removeChild(bannerState);				bannerState = null;								// game class added to stage and referenced				bannerState = new game(this);				addChild(bannerState)								bannerState.playgame();							return;			}						if(bannerSquences[bannerCount][0] == 2){				app_Mode_timer = new appMode(this,15000);			}									// get what banner is active and stop the animation			var child = bannerState.getChildAt(bannerSquences[bannerCount][0]);			child.gotoAndPlay(2);						// garabage collection array			GC.push(bannerState);						if(bannerSquences[bannerCount][0] == 2){				if(app_Mode){					child.getChildAt(0).button_ticket.addEventListener(MouseEvent.CLICK,clickthrough_results);				}else{					child.getChildAt(0).gotoAndStop(2);					child.getChildAt(0).button_ticket.addEventListener(MouseEvent.CLICK,clickthrough_results);					child.getChildAt(0).play_again.addEventListener(MouseEvent.CLICK,resetbanner);				}							}else{				bannerState.addEventListener("CUSTOM_EVENT_TYPE", onCustomListener);			}					}				public function resetbanner(e:Event = null){			GC = [];			// banner animation class removed fomr stage			removeChild(bannerState);			bannerState = null;			app_Mode = true;			stage.addEventListener(MouseEvent.MOUSE_OVER, checkBoundaries_over);			bannerCount = 0			bannerSetUp();		}				public function clickthrough_results(e:Event){			trace("Click through has been called");		}				public function GC_cleanup(){						for(var e:Number= 0; e < GC.length;e++){				GC[0].removeEventListener("CUSTOM_EVENT_TYPE", onCustomListener);			}						GC = [];		}				private function onCustomListener(e:Event) : void {			e.stopImmediatePropagation();						if(bannerCount >= bannerSquences.length - 1){				bannerCount = 0;				bannerState.getChildAt(0).stop();			}else{				bannerCount ++;				runBanners();			}		}									}	}