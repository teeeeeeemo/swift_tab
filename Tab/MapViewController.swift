//
//  ViewController.swift
//  Map
//
//  Created by Lucia on 2017. 2. 21..
//  Copyright © 2017년 Lucia. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var lblLocationInfo1: UILabel!
    @IBOutlet weak var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도 최고 설정 
        locationManager.requestWhenInUseAuthorization() // 위치데이터를 추적하기 위해 사용자에게 승인 요구 
        locationManager.startUpdatingLocation() // 위치 업데이트 시작 
        myMap.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 위도, 경도, 스팬(영역 폭)을 입력받아 지도에 표시
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude lonitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, lonitudeValue) //위도, 경도값
        let spanValue = MKCoordinateSpanMake(span, span) // 범위 값
        let pRegion = MKCoordinateRegionMake(pLocation, spanValue) // pLocation, spanValue -> pRegion
        myMap.setRegion(pRegion, animated: true) // pRegion을 매개변수로 하여 myMap.setRegion함수 호출.
        return pLocation
    }
    
    // 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열을 표시.
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation() // 핀을 설치하기 위해 MKPointAnnotation 함수를 호출.
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span) // annotaition의 coordinate 값을 goLocation함수로부터 CLLocationCoordinate2D형태로 변환하기 위해 goLocation 함수를 수정해야 한다.
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 업데이트되면 먼저 마지막 위치 값을 찾아냄.
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
//        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01) // 마지막 위치의 위도, 경도값으로 goLocation함수 호출.
        // delta값 0.01 : 1의 값보다 지도를 100배로 확대하여 보여줌. 값이 작을수록 확대되는 효과.
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first // placemarks 값의 첫 부분만 pm 상수로 대입.
            let country = pm!.country // pm상수에서 나라 값을 country 상수에 대입.
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()
    }
    
    // 세그먼트 컨트롤을 선택하였을 때 호출.
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // 현재위치
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            // 베를린동물원 !!! >ㅇ<
            setAnnotation(latitude: 52.5079200, longitude: 13.3377550, delta: 0.01, title: "베를린동물원", subtitle:
                "Hardenbergplatz 8, 10787 Berlin, 독일")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "베를린동물원"
        } else if sender.selectedSegmentIndex == 2 {
            // 트라팔가광장 ~~~~
            setAnnotation(latitude: 51.5080390, longitude: -0.1280690, delta: 0.01, title: "트라팔가 광장", subtitle: "Trafalgar Square, London WC2N 5DN 영국")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "트라팔가 광장"
        } else if sender.selectedSegmentIndex == 3 {
            // Tour de 에펠 ㅋㄷㅋㄷㅋㄷ
            setAnnotation(latitude: 48.8583700, longitude: 2.2944810, delta: 0.01, title: "에펠탑", subtitle: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, 프랑스")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "에펠탑"
        }
    }

}

