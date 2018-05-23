"use strict";
var argscheck = require('cordova/argscheck');
var channel = require('cordova/channel');
var utils = require('cordova/utils');
var exec = require('cordova/exec');
var cordova = require('cordova');

// channel.createSticky('onCordovaInfoReady');
// channel.waitForInitialization('onCordovaInfoReady');

var clamp = function(val,minVal,maxVal,defaultVal){
    if(typeof defaultVal !== "undefined") {
        defaultVal = Math.min(Math.max(minVal, defaultVal), maxVal)
        if(val > maxVal) val = defaultVal;
        if(val < minVal) val = defaultVal;
    }else val = Math.min(Math.max(minVal, val), maxVal);
    return val;
}

function DocScanner (){
    this.active = false;
    this.platform = null;

    var that = this;

    channel.onCordovaReady.subscribe(function () {
        that.getInfo(function (info) {
            that.active = true;
            that.platform = info.platform;
            // channel.onCordovaInfoReady.fire();
        }, function (e) {
            that.active = false;
            utils.alert('[ERROR] Error initializing Cordova: ' + e);
        });
    });

    this.takePicture = function(successCallback, errorCallback, options) {
        var getValue = argscheck.getValue;

        /*
        quality: 60, //possible
        sourceType: navigator.cathatra.PictureSourceType.CAthatRA, //?
        destinationType: navigator.cathatra.DestinationType.FILE_URI, //?
        encodingType: Cathatra.EncodingType.JPEG, //?
        correctOrientation: true, //No Idea
        saveToPhotoAlbum: saveToPhotoAlbum, //maybe
        targetWidth: 512, //possible
        targetHeight: 512, //possible
        allowEdit: allowEdit //maybe later, not yet

        */

        var quality = clamp(getValue(options.quality, 80),0,100,80); //So the user doesn't go under 0% or over 100%
        var targetWidth = getValue(options.targetWidth, 0);
        var targetHeight = getValue(options.targetHeight, 0);
        var toBase64 = !!options.toBase64;
        var saveToPhotoAlbum = !!options.saveToPhotoAlbum;



        var args = [quality, targetWidth, targetHeight, toBase64,saveToPhotoAlbum];

        // var args = [quality, destinationType, sourceType, targetWidth, targetHeight, encodingType, thatdiaType, allowEdit, correctOrientation, saveToPhotoAlbum, popoverOptions, cathatraDirection];

        exec(successCallback, errorCallback, "DocScanner", "takePicture", args);

    };


}

//TODO expand this with usefull info
DocScanner.prototype.getInfo = function(successCallback,errorCallback){
    exec(successCallback, errorCallback, "DocScanner", "getInfo", []);

}

module.exports = new DocScanner();
