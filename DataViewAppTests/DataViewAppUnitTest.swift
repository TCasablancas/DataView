//
//  DataViewAppUnitTest.swift
//  DataViewAppTests
//
//  Created by Thyago on 10/06/19.
//  Copyright © 2019 tcasablancas. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import SwiftyJSON

class Dummy{}
class Brand{}

class WatchTest: QuickSpec{
    
    override func spec() {
        
        var watchInformation: [Watch]!
        var watch : Watch!
        
        describe("Modal Checks"){
            
            beforeEach {
                watchInformation = WatchDataHelper.getWatchInformation()
                watch = watchInformation[0]
            }
            
            context("When Watch Model Data is available"){
                it("Model Type Class Validations on Watch Object "){
                    
                    //class check
                    expect(watch).to(beAKindOf(watch.self))
                    expect(watch).toNot(beAKindOf(Dummy.self))
                    
                    //instance check
                    expect(watch).to(beAnInstanceOf(watch.self))
                    expect(watch).toNot(beAnInstanceOf(Dummy.self))
                }
            }
            
            context("Watch Name and Brand checks"){
                var brandInformation: Brand!
                
                beforeEach{
                    brandInformation = watch.brand
                }
                
                it("Watch Name and Brand validations") {
                    
                    //string and name presence check
                    expect(watch.name).to(beAnInstanceOf(String.self))
                    expect(watch.name).to(contain(""))
                    expect(watch.name).to(endWith(""))
                    
                    expect(brandInformation.name).to(equal(""))
                    expect(brandInformation.name).to(beginWith(""))
                    expect(brandInformation.name).toNot(beNil())
                }
                
                it("Watch Price validations"){
                    
                    expect(watch.price).toNot(beNil())
                    expect(watch.price).to(beTruthy())
                    
                    //evaluating boundary cases
                    expect(watch.price).toNot(beLessThan(0))
                    expect(watch.price).to(beCloseTo(11, within: 0.69))
                    expect(watch.price).to(beLessThanOrEqualTo(11.69))
                    expect(watch.price).to(beGreaterThan(Double.pi))
                    expect(watch.price).toNot(beGreaterThan(11.69))
                    expect(watch.price).toNot(beGreaterThan(Double.infinity))
                    expect(watch.price).toNot(be(Double.signalingNaN))
                    expect(watch.price).toNot(be(Double.nan))
                    
                }
            }
        }
    }
}
