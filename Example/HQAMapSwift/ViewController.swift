//
//  ViewController.swift
//  HQAMapSwift
//
//  Created by HQApe on 08/09/2018.
//  Copyright (c) 2018 HQApe. All rights reserved.
//

import UIKit
import HQAMapSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let vc = HQAMapViewController()
        
        self.present(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

