//
//  FirstOnBoardViewController.swift
//  iOptic
//
//  Created by Santhosh on 20/08/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

import UIKit

class FirstOnBoardViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(named: "1_11")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.imageView.animationImages = appDelegate.firstGIF as? [UIImage]
//        self.imageView.animationDuration = 1.5
//        self.imageView.animationRepeatCount = 0
//        self.imageView.startAnimating()
        //self.imageView.image = UIImage(named: "1_11")
    }

    override func didReceiveMemoryWarning() {
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
    
    @IBAction func btnTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.walkthough.nextPage()
    }
    
    func setImages()  {
        
    }
 
}
