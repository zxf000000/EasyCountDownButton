//
//  UIButtonAdd.swift
//  HealthInnovationTech
//
//  Created by 壹九科技1 on 2020/3/19.
//  Copyright © 2020 YJKJ. All rights reserved.
//

import UIKit

var timerKey = "UIBUTTONTIMER"
var totalTimeKey = "UIBUTTON_COUNTDOWN_TOTOALTIME"
var currentTimeKey = "UIBUTTON_COUNTDOWN_CURRENTTIME"


/// 方便倒计时按钮
extension UIButton {
    
    /// 直接调用这个方法开始倒计时
    /// - Parameters:
    ///   - totalTime: 总共需要倒计时的时间
    ///   - changeBlock: 倒计时改变时的回调,回传了当前时间,可以在里面设置自定义title
    ///   - completeHandle: 倒计时结束时的回调,默认状态是回到开始倒计时的状态, 可以在里面恢复初始状态
    open func zxf_countDown(_ totalTime: Int, changeBlock: @escaping ((Int) -> Void), completeHandle: @escaping (() -> Void)) {
        totalTimeInterval = totalTime
        currentTimeInterval = totalTime
        changeBlock(currentTimeInterval ?? 0)
        timer = Timer.zxf_scheduledTimer(with: 1, block: { [weak self] _ in
            guard let strongSelf = self else {return}
            guard var currentTime = strongSelf.currentTimeInterval else {return }
            if currentTime > 0 {
                currentTime -= 1
                strongSelf.currentTimeInterval = currentTime
                changeBlock(currentTime)
            } else {
                currentTime = totalTime
                strongSelf.currentTimeInterval = currentTime
                strongSelf.timer?.invalidate()
                strongSelf.timer = nil
                completeHandle()
            }
        }, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    /// 取消timer
    public func cancelCountDown() {
        timer?.invalidate()
        timer = nil
    }
    /// timer使用自定义的初始化方法, 可以破除循环引用
    private var timer: Timer? {
        set {
            objc_setAssociatedObject(self, &timerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &timerKey) as? Timer
        }
    }
    /// 总时长
    private var totalTimeInterval: Int? {
        set {
            objc_setAssociatedObject(self, &totalTimeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &totalTimeKey) as? Int
        }
    }
    /// 当前时间
    private var currentTimeInterval: Int? {
        set {
            objc_setAssociatedObject(self, &currentTimeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)

        }
        get {
            return objc_getAssociatedObject(self, &currentTimeKey) as? Int
        }
    }
    


}
