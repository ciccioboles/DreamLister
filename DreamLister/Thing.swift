//
//  Thing.swift
//  DreamLister
//
//  Created by David Boles on 2/16/17.
//  Copyright © 2017 David Boles. All rights reserved.
//

import Foundation

extension Thing {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    
}

}

