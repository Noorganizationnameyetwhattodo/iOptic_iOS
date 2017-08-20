//
//  SecondOnBoardViewController.swift
//  iOptic
//
//  Created by Santhosh on 20/08/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit

class SecondOnBoardViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: "2_70")

        // Do any additional setup after loading the view.
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.imageView.animationImages = appDelegate.secondGIF as? [UIImage]
//        self.imageView.animationDuration = 1.5
//        self.imageView.animationRepeatCount = 0
//        self.imageView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
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
    @IBAction func continueTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkthough.nextPage()
    }

}
