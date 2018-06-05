# cordova-plugin-doc-scanner

This plugin defines a global `DocScanner` object, which provides an API for taking pictures and cropping them.


## Installation

    cordova plugin add https://github.com/Skydragonsz/cordova-plugin-document-scanner.git

---

# API Reference <a name="reference"></a>


* [DocScanner](#module_DocScanner)
    * [.takePicture(successCallback, errorCallback, options)](#module_DocScanner.takePicture)
    * [.active] : <code>Boolean</code>
    * [.platform]: <code>String</code> returns the platform on what the plugin is running. (iOS/Android)




---

<a name="module_DocScanner"></a>
## DocScanner
<a name="module_DocScanner.takePicture"></a>
### DocScanner.takePicture(successCallback, errorCallback, options)

Takes a photo using the camera, or retrieves a photo from the device's
image gallery.  The image is passed to the success callback as a
Base64-encoded `String`, or as the URI for the image file.

The `docScanner.takePicture` function opens the device's camera
application that allows users to snap pictures by default.

The return value is sent to the [`successCallback`](#module_DocScanner.onSuccess) callback function, in
one of the following formats, depending on the specified
`scannerOptions`:

- A `String` containing the Base64-encoded photo image.
- A `String` representing the image file location on local storage (default).

You can do whatever you want with the encoded image or URI, for
example:


| Param | Type |
| --- | --- |
| successCallback | <code>[onSuccess](#module_DocScanner.onSuccess)</code> |
| errorCallback | <code>[onError](#module_DocScanner.onError)</code> |
| options | <code>[ScannerOptions](#module_DocScanner.scannerOptions)</code> |

**Example**  
```js
DocScanner.takePicture(successCallback, errorCallback, options);
```

<a name="module_DocScanner.onSuccess"></a>
### successCallback : <code>function</code>
**Example**  
```js
DocScanner.takePicture(successCallback, errorCallback, options);

function successCallback(image){
    var DOMimage = document.getElementById('myImage');
    DOMimage.src = image;
}
```

<a name="module_DocScanner.onError"></a>
### errorCallback : <code>function</code>
**Example**  
```js
DocScanner.takePicture(successCallback, errorCallback, options);

function errorCallback(error){
    console.error("Error",error);
}
```

<a name="module_DocScanner.scannerOptions"></a>
### scannerOptions : <code>Object</code>
Optional parameters to customize the camera settings.


**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| quality | <code>number</code> | <code>80</code> | Quality of the saved image, expressed as a range of 0-100, where 100 is typically full resolution with no loss from file compression. (Note that information about the camera's resolution is unavailable.) |
| targetWidth | <code>number</code> |  | Width in pixels to scale image. Must be used with `targetHeight`. Aspect ratio remains constant. |
| targetHeight | <code>number</code> |  | Height in pixels to scale image. Must be used with `targetWidth`. Aspect ratio remains constant. |
| saveToPhotoAlbum | <code>Boolean</code> | <code>false</code> | Save the image to the photo album on the device after capture. |
| toBase64 | <code>Boolean</code> | <code>false</code> | Gives the Base64 value of the image |

---
