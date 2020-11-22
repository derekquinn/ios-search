//
//  ViewController.swift
//  ios-search
//
//  Created by derek quinn on 11/22/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwapiApiService.getStarshipResponse( completion:{ response in
            
            let starshipResponse: StarshipsResponse = response
            
            print("[SUCCESS] getStarshipResponse Reached ViewController, response =",starshipResponse.results?.debugDescription!)
            
        })
        
    }   
}

