//
//  GlobalFunctions.swift
//  parseSampleApplication
//
//  Created by Alexander Karpov on 05.02.16.
//  Copyright © 2016 Alex Karpov. All rights reserved.
//

import UIKit

func performUI(block: Void->Void) {
    dispatch_async(dispatch_get_main_queue(), {
        block()
    })
}
