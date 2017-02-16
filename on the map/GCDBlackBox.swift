//
//  GCDBlackBox.swift
//  on-the-map
//
//  Created by Ha Na Gill on 2/15/17.
//  Copyright © 2017 Ha Na Gill. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
