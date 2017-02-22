//
//  ViewController.swift
//  ImageView
//
//  Created by Lucia on 2017. 2. 17..
//  Copyright © 2017년 Lucia. All rights reserved.
//

import UIKit
var numImage=0

class ImageViewController: UIViewController {
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    var imgName = ["32497.gif", "1.png", "복실이.jpg", "kkk.jpg"]
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgGallery: UIImageView!
    @IBOutlet weak var btnResize: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imgView.image=UIImage(named: "복실이.jpg")
        imgOn = UIImage(named: "복실이.jpg")
        imgOff = UIImage(named: "kkk.jpg")
        imgGallery.image=UIImage(named: imgName[0])
        
        
        
       
    }

    override func didReceiveMemoryWarning() {
       
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if(isZoom) {
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            
            btnResize.setTitle("확대", for: .normal)
            
        } else {
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            btnResize.setTitle("축소", for: .normal)
            
        }
        isZoom = !isZoom
    }

    @IBAction func preBtn(_ sender: UIButton) {
        numImage = numImage - 1
        if(numImage < 0 ) {
            numImage = imgName.count - 1
        }
        imgGallery.image = UIImage(named: imgName[numImage])
        
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        numImage = numImage + 1
        if(numImage >= imgName.count) {
            numImage = 0
        }
        imgGallery.image = UIImage(named: imgName[numImage])
    }
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
        
    }

}

