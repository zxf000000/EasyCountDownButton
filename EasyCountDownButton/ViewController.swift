//
//  ViewController.swift
//  EasyCountDownButton
//
//  Created by ZXF on 2020/4/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countDownButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }


    @IBAction func tapCountDown(_ sender: UIButton) {
        
        sender.zxf_countDown(10, changeBlock: { [weak sender] (currentSecond) in
            guard let strongSender = sender else {return}
            strongSender.setTitle("倒计时还剩\(currentSecond)s", for: .normal)
            
            print(currentSecond)
            
        }) { [weak sender] in
            guard let strongSender = sender else {return}

            strongSender.setTitle("点击开始倒计时", for: .normal)
            print("倒计时结束")
        }
        
    }
}

