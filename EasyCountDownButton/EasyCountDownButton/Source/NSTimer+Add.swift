//
//  NSTimer+Add.swift
//  HealthInnovationTech
//
//  Created by 壹九科技1 on 2020/4/7.
//  Copyright © 2020 YJKJ. All rights reserved.
//

import Foundation

typealias HITTimerBlock = ((Timer) -> Void)

/// 循环引用解决
extension Timer {
    class func zxf_scheduledTimer(with timeInterval: TimeInterval, block: @escaping HITTimerBlock, repeats: Bool) -> Timer {
        return self.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(zxf_execBlock), userInfo: block, repeats: repeats)
    }
    @objc
    private class func zxf_execBlock(_ timer: Timer) {
        if timer.userInfo != nil {
            let block: HITTimerBlock? = timer.userInfo as? HITTimerBlock
            block?(timer)
        }
    }
}
