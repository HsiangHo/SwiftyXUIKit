//
//  SXUIMethodsHelper.swift
//  SwiftyXUIKit
//
//  Created by Jovi on 3/29/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

import Foundation

func SXUISwizzleMethod(cls:AnyClass?, plusOrMinus:Character, selA:Selector, selB:Selector) -> Bool{
    if nil == cls {
        return false
    }
    var inCls: AnyClass = cls!
    if plusOrMinus == "+"{
        let clsName: UnsafePointer<Int8> = class_getName(inCls)
        inCls = objc_getMetaClass(clsName) as! AnyClass
    }
    let methodA: Method? = class_getInstanceMethod(inCls, selA)
    if nil == methodA {
        return false
    }
    let methodB: Method? = class_getInstanceMethod(inCls, selB)
    if nil == methodB {
        return false
    }
    
    let impA: IMP? = class_getMethodImplementation(inCls, selA)
    if nil == impA {
        return false
    }
    let impB: IMP? = class_getMethodImplementation(inCls, selB)
    if nil == impB {
        return false
    }
    
    class_addMethod(inCls, selA, impA!, method_getTypeEncoding(methodA!))
    class_addMethod(inCls, selB, impB!, method_getTypeEncoding(methodB!))
    
    method_exchangeImplementations(class_getInstanceMethod(inCls, selA)!, class_getInstanceMethod(inCls, selB)!);
    
    return true
}

func SXUIMakeAliasMethod(cls:AnyClass?, plusOrMinus: Character, originalSel: Selector, aliasSel: Selector) -> Bool{
    var bRslt: Bool = false
    var inCls: AnyClass = cls!
    if plusOrMinus == "+"{
        let clsName: UnsafePointer<Int8> = class_getName(inCls)
        inCls = objc_getMetaClass(clsName) as! AnyClass
    }
    let method: Method? = class_getInstanceMethod(inCls, originalSel)
    if nil != method {
        let imp : IMP = method_getImplementation(method!)
        let types: UnsafePointer<Int8>? = method_getTypeEncoding(method!)
        bRslt = class_addMethod(inCls, aliasSel, imp, types);
    }
    return bRslt
}

