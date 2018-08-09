//
//  GaodeMapDataHandler.swift
//  DecorationCompany
//
//  Created by anttoo.zhou on 2017/9/14.
//  Copyright © 2017年 Air. All rights reserved.
//

import UIKit
import MAMapKit
import AMapSearchKit
import AMapLocationKit

let measureMapHeight : CGFloat = 150

public class MeasureMapHandler: NSObject,AMapLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate {
    
    public var gaodeMap : MAMapView?
    public var gaodeLocation : AMapLocationManager?
    public var gaodeSearch : AMapSearchAPI?
    public var gaodeAnnotation : MAPointAnnotation?
    
    public var poiDatas : Array<DCPOIModel> = Array<DCPOIModel>.init()
    public var selectPoiIndex : NSInteger?
    public var poi : DCPOIModel?
    
    public var location : CLLocation?
    
    public var poiBlock : (() -> Void)?
    private var locationBlock : (() -> Void)?
    
    override init() {
        super.init()
        
    }
    
    deinit {
        
    }
    
    //MARK: - API
    
    func locationSetting() {
        self.gaodeLocation = AMapLocationManager.init()
        self.gaodeLocation?.delegate = self
        self.gaodeLocation?.desiredAccuracy = 100
    }
    
    func mapViewAndSearchSetting() {
        self.gaodeMap = MAMapView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2))
        self.gaodeMap?.zoomLevel = 14
        self.gaodeMap?.showsUserLocation = true
        self.gaodeMap?.showsCompass = false
        self.gaodeMap?.showsScale = false
        self.gaodeMap?.userTrackingMode = .follow
        
        self.gaodeAnnotation = MAPointAnnotation.init()
        self.setCenter(location: (self.location)!)
    }
    
    func updateLocation() {
        self.gaodeLocation?.startUpdatingLocation()
    }
    
    func  updateLocationWithLocation(block : @escaping (() -> Void)) {
        self.gaodeLocation?.startUpdatingLocation()
        self.locationBlock = block
    }
    
    func handlePoiData(at index : NSInteger) {
        var idx = 0
        for poi in self.poiDatas {
            if idx == index{
                poi.isSelect = true
            }else{
                poi.isSelect = false
            }
            idx = idx + 1
        }
    }
    
    func checkLocationAuthority(with navi : UINavigationController) -> Bool {
        
        if CLLocationManager.authorizationStatus() != .denied {
            return true
        }else{
            let aleat = UIAlertController(title: "打开定位开关", message:"定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,允许使用定位服务", preferredStyle: .alert)
            let tempAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            }
            let callAction = UIAlertAction(title: "立即设置", style: .default) { (action) in
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                if(UIApplication.shared.canOpenURL(url! as URL)) {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            aleat.addAction(tempAction)
            aleat.addAction(callAction)
            navi.present(aleat, animated: true, completion: nil)
            return false
        }
    }
    
    func setCenter(location : CLLocation) {
        
        self.gaodeMap?.removeAnnotations(self.gaodeMap?.annotations)
        self.gaodeAnnotation?.coordinate = location.coordinate
        self.gaodeMap?.addAnnotation(self.gaodeAnnotation)
        self.gaodeMap?.setCenter(location.coordinate, animated: true)
    }
    
    //MARK: - AMapLocationManagerDelegate
    
    // 定位更新
    public func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        
        self.location = location
        self.locationBlock?()
        self.gaodeLocation?.stopUpdatingLocation()
        
        if self.gaodeMap != nil && self.gaodeSearch != nil {
            self.gaodeMap?.setCenter(location.coordinate, animated: true)
            
            let request = AMapPOIAroundSearchRequest.init()
            request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
            request.radius = 500
            self.gaodeSearch?.aMapPOIAroundSearch(request)
        }
    }
    
    // 定位失败
    public func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        self.locationBlock?()
//        HUD.showCustomProgress(.tip, tip: "定位失败", delay: 0.5)
    }
    
    // 定位权限发生改变
    public func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        
    }
    
    //MARK: - MAMapViewDelegate
    
    //  用户位置或设备方向更新
    public func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
    }
    
    //MARK: - AMapSearchDelegate
    
    // POI检索失败
    public func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        self.poiDatas.removeAll()
//        HUD.showCustomProgress(.tip, tip: "获取周边信息失败", delay: 0.5)
        self.poiBlock?()
    }
    
    // POI检索成功
    public func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        self.poiDatas.removeAll()
        self.gaodeMap?.removeAnnotation(self.gaodeAnnotation!)
        var index : NSInteger = 0
        for poi in response.pois {
            let dcPoi = DCPOIModel.init(poi: poi)
            dcPoi.isSelect = index == 0 ? true : false
            self.poiDatas.append(dcPoi)
            index += 1
        }
        self.selectPoiIndex = 0
        self.poiBlock?()
    }
    
}

public class DCPOIModel: NSObject {
    
    var address : String?
    var detailAdress : String?
    var isSelect : Bool?
    var latitude : CGFloat?
    var longitude : CGFloat?
    
    convenience init(poi : AMapPOI) {
        self.init()
        self.address = poi.name
        self.detailAdress = poi.address
        self.latitude = poi.location.latitude
        self.longitude = poi.location.longitude
        self.isSelect = false
    }
    
    
    
    
}




