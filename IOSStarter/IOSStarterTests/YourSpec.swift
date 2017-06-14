//
//  MySpec.swift
//  IOSStarter
//
//  Created by Matthew Dabit on 6/14/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Quick
import Nimble

class YourSpec: QuickSpec {
    override func spec() {
        describe("YourSpec"){
            context("when this condition met"){
                it("does this thing"){
                    let yourThing = YourThing()
                    expect(yourThing.theThing()).to(beTrue())
                }
            }
        }
    }
}
