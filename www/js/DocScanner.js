"use strict";
var argscheck = require('cordova/argscheck');
var exec = require('cordova/exec');

var docScannerExport = {};

docScannerExport.takePicture = function(successCallback, errorCallback, options) {
    // argscheck.checkArgs('fFO', 'Camera.getPicture', arguments);
    options = options || {};
    // var getValue = argscheck.getValue;

    // var quality = getValue(options.quality, 50);
    // var destinationType = getValue(options.destinationType, Camera.DestinationType.FILE_URI);
    // var sourceType = getValue(options.sourceType, Camera.PictureSourceType.CAMERA);
    // var encodingType = getValue(options.encodingType, Camera.EncodingType.JPEG);
    // var mediaType = getValue(options.mediaType, Camera.MediaType.PICTURE);
    // var allowEdit = !!options.allowEdit;
    // var correctOrientation = !!options.correctOrientation;
    // var saveToPhotoAlbum = !!options.saveToPhotoAlbum;
    // var popoverOptions = getValue(options.popoverOptions, null);
    // var cameraDirection = getValue(options.cameraDirection, Camera.Direction.BACK);
    //
    // var args = [quality, destinationType, sourceType, targetWidth, targetHeight, encodingType,
    //             mediaType, allowEdit, correctOrientation, saveToPhotoAlbum, popoverOptions, cameraDirection];

    // exec(successCallback, errorCallback, "DocScanner", "takePicture", args);


    exec(successCallback, errorCallback, "DocScanner", "takePicture", []);

};

module.exports = docScannerExport;
