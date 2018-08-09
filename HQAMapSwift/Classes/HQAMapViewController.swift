//
//  HQAMapViewController.swift
//  CTMediator
//
//  Created by admin on 2018/8/9.
//

import UIKit
import MAMapKit

public class HQAMapViewController: UIViewController {
    var locationHandler : MeasureMapHandler?
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.locationHandler = MeasureMapHandler.init()
        self.locationHandler?.location = CLLocation(latitude: 26.0, longitude: 116.8)
        self.locationHandler?.mapViewAndSearchSetting()
        
        self.locationHandler?.gaodeMap?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view.addSubview((self.locationHandler?.gaodeMap)!)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
