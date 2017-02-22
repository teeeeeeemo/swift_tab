//
//  ViewController.swift
//  DatePicker
//
//  Created by Lucia on 2017. 2. 20..
//  Copyright © 2017년 Lucia. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    let timeSelector: Selector = #selector(DateViewController.updateTime) //타이머가 구동되면 실행할 함수 지정
    
   // let alertSelector: Selector = #selector(ViewController.updateTime)
    var isAlarmOn = false
    
    
    let interval = 1.0 // interval: 간격 1.0 = 1초
    var count = 0 // 타이머가 설정한 간격대로 실행되는지 확인하기 위한 변수
    var alarmTime: String?
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        // 타이머를 설정하기 위한 scheduledTimer함수
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
       
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblPickerTime.text = "선택시간: " + formatter.string(from: datePickerView.date)
        isAlarmOn = false
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    
    func updateTime() {
//        lblCurrentTime.text = String(count) + "초"
//        count += 1
        
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTime = formatter.string(from: date as Date)
        
        if(alarmTime == currentTime && !isAlarmOn) {
            view.backgroundColor = UIColor.red
           
            let onTimeAlert = UIAlertController(title: "알림", message: "설정된 시간입니다 !!!", preferredStyle: UIAlertControllerStyle.alert)
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertActionStyle.default, handler: nil)
            onTimeAlert.addAction(onAction)
            present(onTimeAlert, animated: true, completion: {
                ACTION in self.isAlarmOn = true
                
            })
        }
        else {
            view.backgroundColor = UIColor.white
            
        }
        
    }

}

