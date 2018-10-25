//
//  AddRating_UserVC.swift
//  OnDemandSaloon
//
//  Created by PS on 09/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import FloatRatingView
class AddRating_UserVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var rewaringRating: FloatRatingView!
    @IBOutlet weak var professionRating: FloatRatingView!
    @IBOutlet weak var resultRating: FloatRatingView!
    @IBOutlet weak var safetyRating: FloatRatingView!
    @IBOutlet weak var qualityRating: FloatRatingView!
    @IBOutlet weak var oneTimeRating: FloatRatingView!
    @IBOutlet weak var lblRewarding: UILabel!
    @IBOutlet weak var lblProfessionalism: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblSafety: UILabel!
    @IBOutlet weak var lblOneTime: UILabel!
    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var CommentsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.CommentsTextView.text = "Comments"
        self.CommentsTextView.textColor = UIColor.lightGray
        
        self.CommentsTextView.layer.cornerRadius = 5
        self.CommentsTextView.layer.borderWidth = 1
        self.CommentsTextView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == CommentsTextView{
            if CommentsTextView.text == "Comments" {
                
                CommentsTextView.text = ""
                CommentsTextView.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == CommentsTextView{
            if CommentsTextView.text == "" {
                
                CommentsTextView.text = "Comments"
                CommentsTextView.textColor = UIColor.lightGray
                
            }
        }
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

}
