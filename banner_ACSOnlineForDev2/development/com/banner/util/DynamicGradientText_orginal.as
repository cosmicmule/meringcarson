﻿package com.banner.util {		//import fl.controls.*;	import flash.display.*;	import flash.events.*;	import flash.geom.*;	import flash.text.*;			/**	 *  Creates a container that holds a text field and a gradient box,	 *  and that sets the text field as a mask on the gradient box to	 *  create the effect of a gradient fill on the text.	 *	 *  @author Anthony Hessler	 */	public class DynamicGradientText extends MovieClip {			private var container:Sprite;		private var text_txt:TextField;		private var currentFont:Font;		private var textFormat:TextFormat;		private var buttonFormat:TextFormat;		private var gradBox:Sprite;		private var fillType:String = GradientType.LINEAR;		private var colors:Array = [0xd6d6d6, 0x4d4c4d,0xd6d6d6];		private var alphas:Array = [1,1,1];		private var ratios:Array = [120, 155, 185];//[100, 145, 185]		private var matr:Matrix = new Matrix();		private var spread:String = SpreadMethod.REFLECT;		private var defaultMessage_str:String;						public function DynamicGradientText(custom_str = "INDYCAR WORLD CHAMPIONSHIPS") {			// set custom string			defaultMessage_str = custom_str;						init();		}								/**		 *  @private		 *  Initialization function that creates all applicable elements, sets		 *  default values and formats, sets mask, and adds elements to display list.		 */		private function init():void {			createContainer();			createTextField();			createFont();			createTextFormats();			createGradientBox();						updateTextField(defaultMessage_str);			//setDefaultTextInput();			setTextMask();			container.addChild(gradBox);			container.addChild(text_txt);			addChild(container);		}				/**		 *  @private		 *  Creation functions. Pretty self-explanatory.		 *		 *  Note: Text field width is hard-coded for this demo. 		 *  It can easily be set using textWidth property.		 */		private function createContainer():void {			container = new Sprite();		}		private function createTextField():void {			text_txt = new TextField();			text_txt.type = TextFieldType.DYNAMIC;			text_txt.width = text_txt.textWidth;			text_txt.border = true;		}		private function createFont():void {			currentFont = new SeptemberBold;		}		private function createTextFormats():void {			textFormat = new TextFormat();			textFormat.font = currentFont.fontName;			textFormat.size = 50;			textFormat.color = 0x333333;			textFormat.bold = true;			textFormat.align = TextFormatAlign.LEFT;		}		private function createGradientBox():void {			// Create at default size of 100x100. Will resize on text update.			gradBox = new Sprite();			matr.createGradientBox(100, 100, Math.PI/2, 0, 0);			gradBox.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spread);			gradBox.graphics.drawRect(0, 0, 100, 100);			gradBox.graphics.endFill();		}						private function updateTextField(pText_str:String):void {			text_txt.width = 506;			text_txt.height = text_txt.textHeight + 12;			text_txt.defaultTextFormat = textFormat;			text_txt.embedFonts = true;			text_txt.antiAliasType = AntiAliasType.ADVANCED;			text_txt.text = pText_str;			text_txt.selectable = false;						gradBox.x = text_txt.x + 3;			gradBox.y = text_txt.y - 3;			gradBox.width = 506;			gradBox.height = text_txt.textHeight + 6;		}				private function setTextMask():void {			gradBox.mask = text_txt;		}	}	}