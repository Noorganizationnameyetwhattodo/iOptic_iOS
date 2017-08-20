//
//  ThirdOnBoardViewController.swift
//  iOptic
//
//  Created by Santhosh on 20/08/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit


class ThirdOnBoardViewController: UIViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.imgView.animationImages = appDelegate.thirdGIF as? [UIImage]
//        self.imgView.animationDuration = 1.5
//        self.imgView.animationRepeatCount = 0
//        self.imgView.startAnimating()
        //self.imageView.image = UIImage(named: "1_11")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func startedTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showLoginScreen()
        UserDefaults.standard.set(true, forKey: "isTutorialShown")

    }

}
