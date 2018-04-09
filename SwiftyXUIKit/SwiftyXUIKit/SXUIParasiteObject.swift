//
//  SXUIParasiteObject.swift
//  SwiftyXUIKit
//
//  Created by Jovi on 4/8/18.
//  Copyright © 2018 Jovi. All rights reserved.
//

import Foundation

private var kProperty = "parasiteKey";

fileprivate class SXUIParasiteObject{
    private var _doct:[String : Any];
    
    init() {
        _doct = [String : Any]()
    }
    
    func setProperty(obj: Any?, key: String) -> Void {
        _doct[key] = obj
    }
    
    func propertyForKey(key: String) -> Any? {
        return _doct[key]
    }
}

fileprivate func set_parasiteObj(parasitifer: Any, obj:SXUIParasiteObject) -> Void {
    objc_setAssociatedObject(parasitifer, &kProperty, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

fileprivate func get_parasiteObj(parasitifer: Any) -> SXUIParasiteObject? {
    return objc_getAssociatedObject(parasitifer, &kProperty) as? SXUIParasiteObject
}

fileprivate func set_property(parasitifer: Any, value: Any?, key:String) -> Void {
    var obj: SXUIParasiteObject? = get_parasiteObj(parasitifer: parasitifer)
    if nil == obj {
        obj = SXUIParasiteObject.init()
        set_parasiteObj(parasitifer: parasitifer, obj: obj!)
    }
    obj!.setProperty(obj: value, key: key)
}

fileprivate func get_property(parasitifer: Any, key: String) -> Any? {
    var rtn:Any? = nil;
    let obj:SXUIParasiteObject? = get_parasiteObj(parasitifer: parasitifer)
    if nil != obj {
        rtn = obj!.propertyForKey(key: key)
    }
    return rtn
}

///Set Property (Extend Object Property)
///
///:params:     1.parasitifer       (Extended object. Swift Do Not support macro, so this param is necessary.)
///             2.value             (Extended property value)
///             3.key               (Extended property key)
///:returns: Void
func SXUI_SET_PROPERTY(parasitifer: Any, value: Any?, key:String) -> Void {
    set_property(parasitifer: parasitifer, value: value, key: key)
}


///Get Property (Extend Object Property)
///
///:params:     1.parasitifer       (Extended object. Swift Do Not support macro, so this param is necessary.)
///             2.key               (Extended property key)
///:returns: Any?                   (Extended property value)
func SXUI_GET_PROPERTY(parasitifer: Any, key: String) -> Any? {
    return get_property(parasitifer: parasitifer, key: key)
}
