//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jacqueline Sloves on 3/2/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL, title:String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}