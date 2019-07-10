//
//  Constants.swift
//  WhatsThat
//
//  Created by Ismayil Hasanov on 11/25/17.
//  Copyright © 2017 GWU. All rights reserved.
//

import AVFoundation
import UIKit

struct Constants {
    static let themeColor: UIColor = .orange
    static let timerInterval: TimeInterval = 10
    
    // Identifiers
    static let photoIdentificationId = "photoIdentification"
    static let photoDetailsId = "photoDetails"
    static let identifiedObjectCellId = "identifiedObjectCell"
    static let favoriteCellId = "favoriteCell"
    static let favoritesMapId = "favoritesMap"
    
    // Button, alert and various item texts
    static let cameraOrPhotoAlbumButtonAlertTitle = "Choose the image source:"
    static let settingsButtonAlertTitle = "Go to Settings"
    static let cancelButtonTitle = "Cancel"
    static let retryButtonTitle = "Retry"
    static let okButtonTitle = "OK"
    static let spinnerLabelText = "Abracadabra"
    static let wikiNoExtractText = "No text available"
    
    // Image names
    static let cameraImageName = "camera"
    static let photoLibraryImageName = "photo-library"
    static let favoriteImageName = "heart"
    static let favoriteFilledImageName = "heart-filled"
    static let mapImageName = "map"
    
    // Photo source
    static let cameraSource = "Camera"
    static let photoLibrarySource = "Photo Library"
    static let cameraMediaType = AVMediaType.video
    
    // Compression quality for image representation throughout
    static let compressionQuality: CGFloat = 0.7
    
    // Permission messages in alert windows
    static let cameraPermissionsErrorMessage = "You need to turn the Camera access on"
    static let photoLibraryPermissionsErrorMessage = "You need to give \"Read and Write\" access in Photos"
    
    // Google Vision API related constants.
    // ADD your key to URL
    static let googleVisionApiUrl = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDIDsQx7-LDEDETrvObj0IDvDJj5-VPMdo"
    static let googleVisionApiMethod = "POST"
    static let googleVisionApiContentType = "application/json"
    
    // Wikipedia extract and page URLs
    static let wikipediaExtractUrl = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&titles="
    static let wikipediaPageUrl = "https://en.wikipedia.org/?curid="
    
    // Twitter API related constants
    // ADD your Twitter key/secret
    static let twitterKey = "YOUR-KEY-HERE"
    static let twitterSecret = "YOUR-SECRET-HERE"
    static let twitterResultType = "popular"
    static let twitterQueryFilter = " filter:media"
}
